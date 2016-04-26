module Dataclip
  class Api
    # Transform:
    # { fields: ["one", "two"], values: [["fila1a", "fila1b"], ["fila2a", "fila2b"]] }
    #
    # Into:
    # [{ "one" => "fila1a", "two" => "fila1b" }, { "one" => "fila2a", "two" => "fila2b" }]
    def self.items dataclip_name
      response = RestClient.get("https://dataclips.heroku.com/#{dataclip_name}.json")
      body = JSON.parse(response.body)

      index = 0
      field_names_by_row_index = body["fields"].each_with_object({}) do |field_name, result|
        result[index] = field_name
        index += 1
      end

      body["values"].map {|row_array|
        index = 0
        result = {}
        row_array.each_with_index do |value, index|
          result[field_names_by_row_index[index]] = value
        end
        result
      }
    end
  end
end
