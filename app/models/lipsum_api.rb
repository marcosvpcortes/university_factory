module University
  class LipsumApi
    #https://gist.github.com/candu/33b256292c492f154ade
    #https://cerkit.com/2016/03/23/getting-filler-text-from-the-lipsum-com-rest-api/
    #http://www.randomtext.me/api/gibberish/p-20/20-50
    URL="http://www.randomtext.me/api/gibberish"
    
    QTD_BUFFER = 500 #number of lines

    @@rest_client = RestClient


    def set_rest_client rc
      @rest_client = rc
    end

    def initialize
      @lines = []
    end

    def get_lipsum qtd=nil
      if(qtd) then
        (1..qtd).map {|i| puts "XUXU #{i}"; get_lipsum;}.join(" ")
      else   
        @lines.pop || update_lines.pop
      end
    end
    
    #.gsub(/(<\/p>)/)
    def update_lines
      response = @@rest_client.get( "#{URL}/p-20/20-50", {content_type: :json, accept: :json})
      lipsum = JSON.parse(response.body)["text_out"]
      @lines = lipsum
        .gsub(/(\r|\n|<p>|)/, "")
        .split("</p>")
        .map {|str| deal_dot str}
    end

    def deal_dot str
       if str.empty?
          return "n/a"
       else
          if str[-1]=="." then
            str
          else
            str+"." 
          end
       end
    end    
  end
end
