-- If the argument is Just, it returns the Just value, otherwise it returns the default value provided as the first argument
fromMaybe defval wrapped =
  case wrapped of
    Nothing     -> defval
    Just value  -> value
