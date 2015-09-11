# a special method that records the current cursor position and allows us to insert contents at that exact position!
# Takes a block to do any work to the code after it's been marked with the current cursor position but before we insert anything in it's place
def insert_at_cursor(string, to_insert, hash = ENV, &blk)
  cursor = [0xFFFC].pack("U").freeze
  line, col = hash["TM_LINE_NUMBER"].to_i - 1, hash["TM_LINE_INDEX"].to_i
  code = string.to_a
  unless hash.has_key?('TM_SELECTED_TEXT')
    if code[line].nil?  # if cursor was on the last line and it was blank
      code << cursor
    else
      code[line][col...col] = cursor
    end
  end
  output = blk.call(code.join)
  array = output.split(cursor)
  array.length == 1 ? array.join << to_insert : array.join(to_insert)
end