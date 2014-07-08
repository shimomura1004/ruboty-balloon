# coding: utf-8

module Ruboty
  module Handlers
    class Balloon < Base
      env :BALLOON_RESPONSE_STYLE, "asakusasatellite: Use 'text' style for AS", optional: true

      on /(?<incident>突然の.+)/, name: "balloon", description: "突然の…"
      on /balloon (?<incident>.+)/, name: "balloon", description: "balloon the message"

      def balloon(message)
        message.reply(generate(message[:incident]))
      end

      private
      def generate(message)
        length = calcLength(message)

        (asakusasatellite? ? "text::\n" : "") +
        [ upper_line(length),
          middle_line(length, message),
          lower_line(length)
        ].join("\n")
      end

      def calcLength(str)
        length = 0
        str.each_char{|c| length += (c.bytesize == 1) ? 1 : 2 }
        return length
      end

      def upper_line(length)
        "＿" + ("人" * ((length + 1) / 2)) + "＿"
      end

      def middle_line(length, line)
        "＞" + line + (length % 2 == 0 ? "" : " ") + "＜"
      end

      def lower_line(length)
        ys = ("Y^" * (length / 2))[0...((length + 1) / 2)]
        "￣" + ys + "" + ys.reverse + "￣"
      end

      def asakusasatellite?
         ENV['BALLOON_RESPONSE_STYLE'] == 'asakusasatellite'
      end
    end
  end
end
