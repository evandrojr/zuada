require 'sinatra'
require 'sinatra/cross_origin'

class MyApp < Sinatra::Base
  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
  
  # routes...
  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    puts "entrou no options interno"
    200
  end
end


options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
 
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  response.headers["Access-Control-Allow-Origin"] = "*"
  puts "entrou no options externo"
  200
end


options '/notify' do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    puts "entrou no options /notify"
    200
end




post '/notify' do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    body = request.body
    body.each{|p| enviar_xmpp(p, 'Barulho', '
    
    Alguém se sentiu incomodado com o seu barulho, por favor pegue leve.
    
    Muito obrigado!')}
    puts body

    body  
    # JSON.parse request.body.read
    # 200
end


  def enviar_xmpp(user, title, message)
    # user = "evandro.leite@sim.serpro.gov.br"
    cmd = %Q(echo "#{message}" | sendxmpp -s "#{title}" #{user})
    r = shell_execute(cmd)
    r != "" ? :error : r
  end

def shell_execute(command, options = {})
    silent = options.fetch(:silent, false)
    raise_error = options.fetch(:raise_error, false)
    puts command unless silent
    output = `#{command}`
    return_code = $?.to_i
    if return_code != 0
      error_msg = "Error: #{output} Code: #{return_code} Command: #{command}"
      puts error_msg
      if raise_error
        fail error_msg
      else
        return return_code
      end
    end
    output
  end