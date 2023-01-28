return {
  s("flink", {
    t({ "{:" }),
    i(1),
    t({ ":}[" }),
    i(2),
    t({ "]" }),
  }),
  s("cbrust", {
    t({"@code rust"}),
    t({"", ""}), i(1),
    t({"", "@end"}),
  }),
  s("cbpython", {
    t({"@code python"}),
    t({"", ""}), i(1),
    t({"", "@end"}),
  }),
  s("cblua", {
    t({"@code lua"}),
    t({"", ""}), i(1),
    t({"", "@end"}),
  }),
}
