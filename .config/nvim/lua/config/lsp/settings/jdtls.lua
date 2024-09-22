local jdtls = require("jdtls")
local lsp = require("plug.lsp.handlers")
local global = require("config.globals").jdtls

local HOME = os.getenv("HOME")
local XDG_DATA_HOME = os.getenv("XDG_DATA_HOME")

local LSP_SERVER = HOME .. "/dev/eclipse/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/"
local JAVA = HOME .. "/.local/jdks/jdk-17.0.2+8/bin/java" -- NOTE: must be the same as the one to compile jdtls and jdtls-dap
local WORKSPACE_PATH = XDG_DATA_HOME .. "/jdtls-workspace/"
local CONFIG = "linux"

-- set the capabilities
local capabilities = lsp.capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
capabilities = vim.tbl_deep_extend("force", extendedClientCapabilities, capabilities)

local ROOT_MARKERS = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "src" }
local JAR_PATTERNS = {
  "/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
  "/dev/dgileadi/vscode-java-decompiler/server/*.jar",
  "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar",
  "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar",
  "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar",
}

-- Find the root of the project
local ROOT_DIR = require("jdtls.setup").find_root(ROOT_MARKERS)
assert(ROOT_DIR ~= nil and ROOT_DIR ~= "", "Root directory can not be determined!")

local PROJECT_NAME = vim.fn.fnamemodify(ROOT_DIR, ":p:h:t")
local WORKSPACE_DIR = WORKSPACE_PATH .. PROJECT_NAME

-- npm install broke: https://github.com/npm/cli/issues/2508
-- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
-- stolen from mfussnegger
local function get_bundles(jar_patterns)
  local plugin_path =
    "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/"
  local bundle_list = vim.tbl_map(function(x) return require("jdtls.path").join(plugin_path, x) end, {
    "junit-jupiter-*.jar",
    "junit-platform-*.jar",
    "junit-vintage-engine_*.jar",
    "org.opentest4j*.jar",
    "org.apiguardian.api_*.jar",
    "org.eclipse.jdt.junit4.runtime_*.jar",
    "org.eclipse.jdt.junit5.runtime_*.jar",
    "org.opentest4j_*.jar",
  })

  vim.list_extend(jar_patterns, bundle_list)
  local bundles = {}
  for _, jar_pattern in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(HOME .. jar_pattern), "\n")) do
      if
        not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
        and not vim.endswith(bundle, "com.microsoft.java.test.runner.jar")
      then
        table.insert(bundles, bundle)
      end
    end
  end

  return bundles
end

local function read_libs(project_root)
  if not (vim.fn.filereadable(project_root .. "/.classpath") == 1) then
    local find_jar_libs_cmd = "find " .. project_root .. "/libs -type f | grep jar"
    return require("config.helper").cmd_to_table(find_jar_libs_cmd)
  end

  -- There is .classpath file
  local number_of_non_existent_jars = 0
  local extract_classpathentries_cmd = "grep 'classpathentry kind=\"lib\"' "
    .. project_root
    .. "/.classpath | sed 's/.*classpathentry kind=\"lib\" path=\"//' | sed 's/\".*//'"
  local jars = require("config.helper").cmd_to_table(extract_classpathentries_cmd)

  local new_table = {}
  for _, jar_file in ipairs(jars) do
    jar_file = project_root .. "/" .. jar_file
    if vim.fn.filereadable(jar_file) == 1 then
      table.insert(new_table, jar_file)
    else
      number_of_non_existent_jars = number_of_non_existent_jars + 1
    end
  end

  if number_of_non_existent_jars > 0 then
    vim.notify(
      string.format("There are %s entries in the .classpath file, that do not exist!", number_of_non_existent_jars)
    )
  end
  return new_table
end

return {
  cmd = {
    JAVA,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    vim.fn.glob(LSP_SERVER .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

    "-configuration",
    LSP_SERVER .. "/config_" .. CONFIG,

    "-data",
    WORKSPACE_DIR,
  },
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    jdtls.setup_dap({
      hotcodereplace = "auto",
      config_overrides = {
        vmArgs = global.vmArgs,
        args = global.args,
      },
    })

    require("jdtls.dap").setup_dap_main_class_configs() -- needs to be called to activate the dap function
  end,
  root_dir = ROOT_DIR,
  -- NOTE: look here for a list of options:
  -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      signatureHelp = { enabled = true },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = HOME .. "/.local/jdks/jdk8u332-b09/",
          },
          {
            name = "JavaSE-11",
            path = HOME .. "/.local/jdks/jdk-11.0.9.1+1/",
          },
          {
            name = "JavaSE-15",
            path = HOME .. "/.local/jdks/jdk-15.0.2+7/",
          },
          {
            name = "JavaSE-16",
            path = HOME .. "/.local/jdks/jdk-16.0.1+9/",
          },
          {
            name = "JavaSE-17",
            path = HOME .. "/.local/jdks/jdk-17.0.2+8/",
            default = true,
          },
          {
            name = "JavaSE-18",
            path = HOME .. "/.local/jdks/jdk-18+36/",
          },
        },
      },
      project = {
        -- import all jar files under the libs directory
        referencedLibraries = read_libs(ROOT_DIR),
      },
      referenceCodeLens = {
        enabled = true,
      },
      format = {
        enabled = false,
      },
      codeGeneration = {
        tostring = {
          listArrayContents = true,
          skipNullValues = true,
        },
        useBlocks = true,
        hashCodeEquals = {
          useInstanceof = true,
          useJava7Objects = true,
        },
        generateComments = false,
        insertLocation = true,
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
    },
  },
  init_options = {
    bundles = get_bundles(JAR_PATTERNS),
  },
}
