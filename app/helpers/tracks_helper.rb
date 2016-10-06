module TracksHelper
  def ugly_lyrics(text)
    html = "\n<pre>"

    text.lines.each do |line|
      html += "\n\t&#9835 #{h(line)}"
    end

    html += "\n</pre>"

    html.html_safe
  end
end
