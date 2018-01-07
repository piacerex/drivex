defmodule GoogleDrive do
	def access_token() do
		{ :ok, %{ token: token } } = Goth.Token.for_scope( "https://www.googleapis.com/auth/drive" )
		token
	end

	defp domain(), do: "https://www.googleapis.com"
	defp header(), do: [ "Authorization": "Bearer " <> access_token() ]

	def get_user(), do: Json.get( domain(), "/drive/v3/about?fields=user", header() )

	def list_file(),        do: Json.get( domain(), "/drive/v3/files",                                  header() )
	def list_file( query ), do: Json.get( domain(), "/drive/v3/files?q=name%20contains%20'#{ query }'", header() )

	def copy_file( from_id ),               do: Json.post( domain(), "/drive/v3/files/#{ from_id }/copy", "",                              header() )
	def copy_file( from_id, new_filename ), do: Json.post( domain(), "/drive/v3/files/#{ from_id }/copy", "{ name: '#{ new_filename }' }", header() )

	def create_file(), do: Json.post( domain(), "/upload/drive/v3/files", "", header() )

	def list_permissions( id ), do: Json.get( domain(), "/drive/v3/files/#{ id }/permissions", header() )
end
