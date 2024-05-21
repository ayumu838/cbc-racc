
class Cbc

preclow
  left '.'
prechigh

rule
  program   : statment { p "result is #{result} val is #{val}" }
            ;
  statment  : { result = val[0]};
end

---- header

---- inner

  def parse(str)
    @tokens ||= []

    until str.nil? || str.empty?
      case str
      when /\A\s+/
        # do nothing
      when /\Avoid/
        @tokens << [:VOID, $&]
      when /\Achar/
        @tokens << [:CHAR, $&]
      when /\Ashort/
        @tokens << [:SHORT, $&]
      when /\Aint/
        @tokens << [:INT, $&]
      when /\Along/
        @tokens << [:LONG, $&]
      when /\Astruct/
        @tokens << [:STRUCT, $&]
      when /\Aunion/
        @tokens << [:UNION, $&]
      when /\Aenum/
        @tokens << [:ENUM, $&]
      when /\Astatic/
        @tokens << [:STATIC, $&]
      when /\Aextern/
        @tokens << [:EXTERN, $&]
      when /\Aconst/
        @tokens << [:CONST, $&]
      when /\Asigned/
        @tokens << [:SIGNED, $&]
      when /\Aunsigned/
        @tokens << [:UNSIGNED, $&]
      when /\Aif/
        @tokens << [:IF, $&]
      when /\Aelse/
        @tokens << [:ELSE, $&]
      when /\Aswitch/
        @tokens << [:SWITCH, $&]
      when /\Acase/
        @tokens << [:CASE, $&]
      when /\Adefault/
        @tokens << [:DEFAULT_, $&]
      when /\Awhile/
        @tokens << [:WHILE, $&]
      when /\Ado/
        @tokens << [:DO, $&]
      when /\Afor/
        @tokens << [:FOR, $&]
      when /\Areturn/
        @tokens << [:RETURN, $&]
      when /\Abreak/
        @tokens << [:BREAK, $&]
      when /\Acontinue/
        @tokens << [:CONTINUE, $&]
      when /\Agoto/
        @tokens << [:GOTO, $&]
      when /\Atypedef/
        @tokens << [:TYPEDEF, $&]
      when /\Aimport/
        @tokens << [:IMPORT, $&]
      when /\Asizeof/
        @tokens << [:SIZEOF, $&]

      when /[a-zA-Z_]\w*/
        @tokens <<  [:IDENTIFIER, $&]
      when /.*/
        # do nothing
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

