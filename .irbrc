require 'irb/completion'
require 'irb/ext/save-history'
#History configuration
IRB.conf[:SAVE_HISTORY] = 100000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

class String
  def format_url
    if self.blank?
      return self
    elsif self.include?("linkedin.com")
      uri = Addressable::URI.heuristic_parse(self)
      result = uri.domain + uri.path
      result = result.sub(/\/$/, "")
      return result
    end
    return self.sub(/^https?\:\/\/(www.)?/,'')
  end

  def parse_json
    JSON.parse(self) rescue self
  end
end

class Array
  def html_safe
    result = "<ul>"
    self.each do |item|
      li = "<li><strong>#{item}</strong></li>"
      result = result + li
    end
    result = result + "</ul>"
    return result.html_safe
  end

  def breakup
    result = Hash.new(0)
    self.uniq.each do |a|
      result[a] = self.count(a)
    end
    return result
  end
end

class Hash
  def method_missing(m, *args, &blk)
    fetch(m) { fetch(m.to_s) { super } }
  end
  
  def get_schema(hash)
  result = {}
  hash.each do |k,v|
    if v.class == Hash
      result[k] = get_schema(v)
    elsif v.class == Array
      
    else
      result[k] = v.class.to_s
    end
  end
  return result
end

end


