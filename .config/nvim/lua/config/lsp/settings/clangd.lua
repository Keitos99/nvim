return {
  -- HACK: for the "Multiple different client offset_encodings detected" error
  -- look here: https://www.reddit.com/r/neovim/comments/12qbcua/comment/jgpqxsp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
