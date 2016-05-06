require 'net/http'
require 'json'

#The Internet Chuck Norris Database
server = "http://api.icndb.com"

#Id of the widget
id = "chuck"

#The Array to take the names from
teammembers = [['Adrian', 'Cuadros'],['Elias', 'Matheus'],['Chelo', 'Gomez'],['Samuel','Heaney'],['Johnny', 'Mike'],['Omar', 'Garza'],['Sebas', 'Gutierrez'],['Angel', 'Huerta'],['Gustavo', 'Troconis']]

SCHEDULER.every '15s', :first_in => 0 do |job|
    random_member = teammembers.sample
    firstName = random_member[0]
    lastName = random_member[1]

    #The uri to call, swapping in the team members name
     uri = URI("#{server}/jokes/random?firstName=#{firstName}&lastName=#{lastName}&limitTo=[nerdy]")

    #This is for when there is no proxy
    res = Net::HTTP.get(uri)

    #marshal the json into an object
    j = JSON[res]

    #Get the joke
    joke = j['value']['joke']

    #Send the joke to the text widget
    send_event(id, { title: "#{firstName} #{lastName} Facts", text: joke })

end
