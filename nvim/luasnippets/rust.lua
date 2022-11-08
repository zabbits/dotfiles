return {
  s("modt", {
    t({ "#[cfg(test)]", "mod tests {", "    use super::*;", "    " }),
    i(1),
    t({ "", "}" }),
  }),
}
