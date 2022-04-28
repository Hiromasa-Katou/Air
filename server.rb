require 'sinatra'
require 'sinatra/cookies'
require 'mongoid'
require "grover"

set :port, 80
set :bind, '0.0.0.0'

apartments = {
  denhaag1: {
    price: 1325,
    title: 'Den Haag: Archipel appartement',
    location: 'Den Haag',
    bedrooms: 2,
    description: 'Dit appartement met twee ruime slaapkamers is in goede staat en biedt veel ruimte en charme. Het ligt om de hoek van alle internationale organisaties, verschillende ambassades en Shell. De winkelstraat "Bankastraat" is op loopafstand en biedt veel leuke boetiekjes, restaurants en lunchrooms. Openbaar vervoer en de snelwegen zijn tevens op dichtbij en biedt hierdoor gemakkelijke toegang tot het stadscentrum, het strand van Scheveningen en alle uitvalswegen richting Rotterdam en Amsterdam.Indeling: eigen entree op begane grond, trap naar de eerste verdieping van het appartement. Vanuit de gang komt u in de ruime en lichte woonkamer met eetkamer aan de achterzijde. De gehele eerste etage is voorzien van een mooie houten vloer. De moderne, separaat gesitueerde keuken is voorzien van alle inbouwapparatuur zoals een oven, vriezer en vaatwasser. Er is een apart gastentoilet met wastafel in de gang.Trap naar de tweede verdieping. Ruime overloop met de cv-installatie in knieschot weggewerkt met schuifdeuren. Beide charmante slaapkamers zijn toegankelijk via de hal en zijn uitgerust met ingebouwde kasten. Tussen beide slaapkamers bevindt zich de nette en zeer grote badkamer die is uitgerust met een douche, bad, toilet en wastafel. Zeer ruim en charmant appartement, ideaal voor mensen die dicht bij hun werk en het centrum van de stad willen wonen.'
  },
  rotterdam1: {
    price: 1790,
    title: 'Luxe gemeubileerd 4-kamer appartement',
    bedrooms: 3,
    location: 'Rotterdam',
    description: 'TE HUUR: Een zeer luxe gemeubileerd 4-kamerappartement op de 12de verdieping met parkeerplaats nummer 182 (gratis) en inpandig terras, welke een spectaculair uitzicht biedt op het Boerengat, de Maas en sky-line van Rotterdam. Zeer gunstig gelegen ten overstaan van openbaar vervoer (metro, tram en trein) en uitvalswegen. Winkels, diverse restaurants en uitgaansgelegenheden in de nabije omgeving. Alle voorzieningen van Kralingen en het centrum op ongeveer 10 minuten loopafstand.'
  },
  amsterdam1: {
    price: 1325,
    title: 'Gerenoveerd en nieuw gemeubileerd appartement met 2 slaapkamers',
    location: 'Amsterdam',
    bedrooms: 2,
    description: "Beveiligde entree met intercomsysteem en postbussen.Ingang van het appartement, hal met toilet. Fantastisch ingerichte Z-vormige woonkamer met open keuken die volledig is uitgerust met een koelkast met vriesvak, vaatwasser, magnetron / oven, vaatwasser en spoelbak met geïntegreerde Quooker. Via openslaande deuren toegang tot het heerlijke balkon met buitenlicht en elektriciteit.Aan de andere kant van het appartement vindt u de berging met een wasmachine en droger.Ouderslaapkamer ingericht met een tweepersoonsbed, grote kledingkast. Tweede slaapkamer met een slaapbank. De goed uitgeruste badkamer is afgewerkt met een ligbad, inloopdouche en wastafel met een spiegel. <br> Opmerkingen:<br>- De huurprijs is exclusief gas, water en elektra, tv / internet en gemeentelijke belastingen;<br>- Laminaat in het hele appartement;<br>- Centrale verwarming en mechanische ventilatie;<br>- Exclusief maandelijkse servicekosten van € 130,00;<br>- Borg: 2 maanden huur<br>- Fietsenstalling op de begane grond en berging in het appartement;<br>- De minimale huurperiode is 2 maanden."
  }
}

class Apartment
  include Mongoid::Document
  field :apt_id, type: String
  field :price, type: Integer
  field :title, type: String
  field :location, type: String
  field :bedrooms, type: Integer
  field :description, type: String
  field :neighbour, type: String
  field :host_name, type: String
  field :host_street, type: String
  field :host_city, type: String
  field :host_country, type: String
  field :bank_name, type: String
  field :account_holder, type: String
  field :account_number, type: String
  field :bic, type: String

end


class Guest
  include Mongoid::Document
  field :client_id, type: String, default: -> { SecureRandom.hex 4 }
  field :invoice_id, type: Integer, default: -> { rand * 100000000000}
  field :selected_property, type: String
  field :checkin_timestamp, type: Integer
  field :number_of_months, type: Integer
  field :number_of_guests, type: Integer
  field :first_name , type: String
  field :last_name , type: String
  field :address , type: String
  field :city , type: String
  field :zip , type: String
  field :country , type: String
  field :phone , type: String
end

Mongoid.load!('mongo.yml')

get '/' do
  redirect 'https://www.airbnb.nl'
end

get '/setup' do
  apts = Apartment.all
  erb :setup, locals: {apts: apts}
end

post '/setup' do
  apt_id = params[:apt_id].downcase.to_sym
  path = "public/images/#{apt_id}"
  Dir.mkdir(path) unless File.exists?(path)
  Apartment.create(
    apt_id: apt_id,
    price: params['price'],
    title: params['title'],
    location: params['location'],
    bedrooms: params['bedrooms'],
    description: params['description'],
    neighbour: params['neighbour'],
    host_name: params['host_name'],
    host_street: params['host_street'],
    host_city: params['host_city'],
    host_country: params['host_country'],
    bank_name: params['bank_name'],
    account_holder: params['account_holder'],
    account_number: params['account_number'],
    bic: params['bic']
  )
  redirect '/setup'
end

post '/setup/:apt_id' do
  apt_id = params[:apt_id].downcase.to_sym
  apt = Apartment.where(apt_id: apt_id).first
  apt.set(
    price: params['price'],
    title: params['title'],
    location: params['location'],
    bedrooms: params['bedrooms'],
    description: params['description'],
    neighbour: params['neighbour'],
    host_name: params['host_name'],
    host_street: params['host_street'],
    host_city: params['host_city'],
    host_country: params['host_country'],
    bank_name: params['bank_name'],
    account_holder: params['account_holder'],
    account_number: params['account_number'],
    bic: params['bic']
  )
  redirect '/setup'
end

get '/setup/delete/:apt_id' do
  apt_id = params[:apt_id].downcase.to_sym
  Apartment.where(apt_id: apt_id).delete
  FileUtils.remove_dir("public/images/#{apt_id}",true)
  redirect '/setup'
end

post '/setup/upload/:apt_id' do
  apt_id = params[:apt_id].downcase.to_sym
  path = "public/images/#{apt_id}"

  k = params['images'].map{ |f| f[:filename] }.join(";")
  $param = k.chomp.split(";")
  array_length = $param.length       # or $param.size
  array_lengthx = array_length

  i = 0
  while i.to_i < array_lengthx do
    fname = params[:images][i][:filename]
    file = params[:images][i][:tempfile]
    File.open("#{path}/#{fname}", 'wb') do |f|
      f.write file.read
    end
    i += 1
  end
  redirect '/setup'
end

get '/apartments/:apartment_id' do
  apt_id = params[:apartment_id].downcase.to_sym
  apt = Apartment.where(apt_id: apt_id).first
  halt 404 unless apt
  if !cookies['client_id']
    client = Guest.create
    cookies['client_id'] = client.client_id
  end
  apt[:description] = apt[:description].gsub("\n", "<br/>") unless apt[:description].nil?;
  apt[:neighbour] = apt[:neighbour].gsub("\n", "<br/>") unless apt[:neighbour].nil?;
  host_name = apt[:host_name].split(' ').first;
  erb :air_step1, locals:{apt_id: apt_id.to_s, host_name: host_name, apt: apt, booked: ( cookies['client_id'] && Guest.where(client_id: cookies['client_id']).first.first_name)}
end

post '/update_guest' do
  client = Guest.where(client_id: cookies['client_id']).first
  halt 404 unless client
  halt 400 unless params['maanden'].to_i > 0
  halt 400 unless params['number_of_guests'].to_i > 0
  begin
    checkin_timestamp = Date.strptime(params['checkin'], '%m/%d/%Y')
  rescue ArgumentError
    halt 400
  end
  client.set(
    selected_property: params['selected_property'],
    number_of_months: params['maanden'].to_i,
    number_of_guests: params['number_of_guests'].to_i,
    checkin_timestamp: checkin_timestamp.to_time.to_i
  )
  # puts request.body.raw
  redirect '/confirm'
end

get '/confirm' do
  client = Guest.where(client_id: cookies['client_id']).first
  apt = Apartment.where(apt_id: client.selected_property).first
  halt 404 unless client && client.checkin_timestamp
  checkin_timestamp = Time.at(client.checkin_timestamp)
  erb :air_step2, locals: {months: client.number_of_months, checkin: checkin_timestamp, apt_id: client.selected_property, apt: apt, client: client}
end

post '/confirm' do
  client = Guest.where(client_id: cookies['client_id']).first
  halt 404 unless client
  # first_name=A &last_name=A &address1=Aa &postal_code=1111jz &city=Zaanstad &country=NL &phone=088888888
  client.set(
    first_name: params['first_name'],
    last_name: params['last_name'],
    city: params['city'].capitalize,
    country: params['country'],
    address: params['address1'],
    phone: params['phone']
  )
  redirect '/invoice'
end

get '/invoice' do
  client = Guest.where(client_id: cookies['client_id']).first
  apt = Apartment.where(apt_id: client.selected_property).first
  halt 404 unless client
  erb :air_step3, locals: {client: client, apt: apt}
end

post '/upload' do
  client = Guest.where(client_id: cookies['client_id']).first
  tempfile = params['fileToUpload'][:tempfile] 
  filename = params['fileToUpload'][:filename]
  directory_name = "uploads/#{client.invoice_id}"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)
  File.open("#{directory_name}/#{filename}", "w") do |f|
    f.write(tempfile.read)
  end
  redirect("apartments/#{client.selected_property}")
end

get '/invoice_file' do
  client = Guest.where(client_id: cookies['client_id']).first
  apt = Apartment.where(apt_id: client.selected_property).first
  halt 404 unless client
  source = erb(:invoice, locals: {client: client, apt: apt})
  Grover.configure do |config|
    config.options = {
      format: 'A4',
      margin: {
        top: '2cm',
        bottom: '3cm',
        left: '1.9cm',
        right: '1.9cm'
      }
    }
  end
  Grover.new(source).to_pdf("./invoices/#{client.invoice_id}.pdf")
  send_file "./invoices/#{client.invoice_id}.pdf"
end
