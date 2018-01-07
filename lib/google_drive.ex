defmodule GoogleDrive do
	@moduledoc """
	Google Drive API wrapper library.
	"""

	@doc """
	Get Google Drive API access token (from config/client_secret.json)
	"""
	def access_token() do
		{ :ok, %{ token: token } } = Goth.Token.for_scope( "https://www.googleapis.com/auth/drive" )
		token
	end

	defp domein(), do: "https://www.googleapis.com/drive"
	defp files(),  do: domein() <> "/v3/files"
	defp about(),  do: domein() <> "/v3/about"
	defp header(), do: [ "Authorization": "Bearer " <> access_token(), "Content-type": "application/json" ]

	defp request( custom ),                  do: "{ #{ custom } }"
	defp request( custom, name ),            do: "{ #{ custom }, #{ name( name ) } }"
	defp request( custom, name, parent_id ), do: "{ #{ custom }, #{ name( name ) }, #{ parent( parent_id ) } }"

	defp fields(), do: "id,kind,mimeType,modifiedTime,name,owners,parents,starred,trashed,viewedByMeTime,properties"

	defp type_text(),       do: mime_type( "text/plain" )
	defp type_folder(),     do: mime_type( "application/vnd.google-apps.folder" )
	defp mime_type( type ), do: "mimeType: '#{ type }'"

	defp name( name ),      do: "name: '#{ name }'"
	defp parent( id ),      do: "parent: [ '#{ id }' ]"
	defp writer( email ),   do: "role: 'writer', type: 'user', emailAddress: '#{ email }'"
#	defp owner( email ),    do: "role: 'owner',  type: 'user', emailAddress: '#{ email }', transferOwnership: 'true'"

	def get_user(), do: Json.get( about(), "?fields=user", header() )

	@doc """
	List Google Drive files/folders

	## Examples
		iex> GoogleDrive.list() |> Map.keys
		["files", "incompleteSearch", "kind"]
		iex> GoogleDrive.list()[ "files" ] |> List.first |> Map.keys
		["id", "kind", "mimeType", "name"]
	"""
	def list(),        do: Json.get( files(), "",                                  header() )
	def list( query ), do: Json.get( files(), "?q=name%20contains%20'#{ query }'", header() )

	@doc """
	Get Google Drive file/folder info
	"""
	def get( id ), do: Json.get( files(), "/#{ id }?fields=#{ fields() }", header() )

	@doc """
	Copy Google Drive file/folder
	"""
	def copy( from_id ),           do: Json.post( files(), "/#{ from_id }/copy", "",                          header() )
	def copy( from_id, new_name ), do: Json.post( files(), "/#{ from_id }/copy", request( name( new_name ) ), header() )

	@doc """
	Create Google Drive file
	"""
	def create_file(),                    do: Json.post( files(), "", request( type_text() ),                    header() )
	def create_file( name ),              do: Json.post( files(), "", request( type_text(), name ),              header() )
	def create_file( name, parent_id ),   do: Json.post( files(), "", request( type_text(), name, parent_id ),   header() )

	@doc """
	Create Google Drive folder
	"""
	def create_folder(),                  do: Json.post( files(), "", request( type_folder() ),                  header() )
	def create_folder( name ),            do: Json.post( files(), "", request( type_folder(), name ),            header() )
	def create_folder( name, parent_id ), do: Json.post( files(), "", request( type_folder(), name, parent_id ), header() )

	@doc """
	Rename Google Drive file/folder
	"""
	def rename( id, name ), do: Json.patch( files(), "/#{ id }", request( name( name ) ), header() )

	@doc """
	Delete Google Drive file/folder
	"""
	def delete( id ), do: Json.delete( files(), "/#{ id }", header() )

	@doc """
	List Google Drive file/folder's permissions
	"""
	def list_permissions( id ), do: Json.get( files(), "/#{ id }/permissions", header() )

	@doc """
	Add Google Drive file/folder's writer permission
	"""
	def add_writer( id, email ), do: Json.post( files(), "/#{ id }/permissions", request( writer( email ) ), header() )

	@doc """
	Delete Google Drive file/folder's permission
	"""
	def delete_permission( id, permission_id ), do: Json.delete( files(), "/#{ id }/permissions/#{ permission_id }", header() )
end
