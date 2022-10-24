return {
  s("modt", {
    t({ "#[cfg(test)]", "mod test {", "    use super::*;", "    " }),
    i(1),
    t({ "", "}" }),
  }),
}
