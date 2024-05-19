def filter_paste(inp: str):
    # Remove <CR>'s while pasting
    return inp.replace("\r", "")
