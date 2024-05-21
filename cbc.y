
class Cbc

preclow
  left '.'
prechigh

rule
  program : stmt { p "result is #{result} val is #{val}" }
          ;
  stmt    : expr tEND { result = val[0]; p "stmt is #{result}" }
          | expr { result = val[0]; p "stmt expr is #{result}" }
          ;
  expr    : primary { result = val[0]; p "primary is #{result}" }
          | tSTRLIT expr tSTRLIT =STRING { result = "'#{val[1]}'"; p "string is #{result}" }
          | expr expr { result = val.join(' '); p "expr expr is #{result}" }
          ;
  primary : INTEGER {resut = val[0]}
          | IDENTIFIER { resut = val[0]}
          | tEND { result = val[0]}
          | tLITERAL { result = val[0]}
          | '{' expr '}' { result = "{ #{val[1]} }"}
          | '(' expr ')' { result = "( #{val[1]} )"}
          | expr '.' expr { result = val.join}
          ;
end

---- header

---- inner

  def parse(str)
    @tokens ||= []
    until str.nil? || str.empty?
      case str
      when /\A\s+/
        # do nothing
      when /\A\d+/
        @tokens <<  [:INTEGER, $&.to_i]
      when /\A\./
        @tokens << ['.', $&]
      when /\A\(/
        @tokens << ['(', $&]
      when /\A\)/
        @tokens << [')', $&]
      when /\A\{/
        @tokens << ['{', $&]
      when /\A\}/
        @tokens << ['}', $&]
      when /\A,/
        @tokens << [:tLITERAL, $&]
      when /\A'/
        @tokens << [:tSTRLIT, $&]
      when /A"/
        @tokens << [:tSTRLIT, $&]
      when /\A,/
        @tokens << [:IDENTIFIER, $&]
      when /\A\;/
        @tokens << [:tEND, $&]
      when /\A\w+/
        @tokens <<  [:IDENTIFIER, $&]
      end
      str = $'
    end
    @tokens << [false, '$']
    p @tokens
    do_parse
  end

  def next_token
    @tokens.shift
  end


---- footer

parser = Cbc.new
File.open('src/hello-world.cbc') do |f|
  begin
    p parser.parse(f.readlines.join(' '))
  rescue => e
    puts e
  end
end

puts "\n"

