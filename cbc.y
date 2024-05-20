
class Cbc

preclow
  left '.'
prechigh

rule
  program : expr { p "result is #{result} val is #{val}" }
          ;
  expr    : expr expr { result = val.join(' ')}
          | primary { result = val[0]}
          | expr '.' expr { result = val.join}
          ;
  primary : NUMBER {resut = val[0] }
          | TEST { resut = val[0] }
          ;
end

---- header

---- inner

  def parse(str)
    @tokens ||= []
    until str.empty?
      case str
      when /\A\s+/
        # do nothing
      when /\A[a-zA-Z_]+/
        @tokens <<  [:TEST, $&]
      when /\A\d+/
        @tokens <<  [:NUMBER, $&.to_i]
      when /\./
        @tokens << ['.', $&]
      end
      str = $'
      break if str.nil?
    end
    @tokens << [false, '$']
    do_parse
  end

  def next_token
    @tokens.shift
  end


---- footer

parser = Cbc.new
begin
  p parser.parse('file.read aaa 1111 hoge')
rescue => e
  puts 'end'
  puts e
end

puts "\n"

