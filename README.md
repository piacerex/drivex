# Drivex

[Drivex](https://hex.pm/packages/drivex) is a Google Drive API Elixir wrapper library. Here is an example:

```elixir
iex> GoogleDrive.list()
%{"files" => [%{"id" => "1tDgypK1qrcg0oule4Cxxxxxxxy0L7CwN82G0JxC8",
     "kind" => "drive#file",
     "mimeType" => "application/vnd.google-apps.spreadsheet", "name" => "spreadsheet1"},
   %{"id" => "0B8yV3717Z-lxxxxxxxxxDaVE", "kind" => "drive#file",
     "mimeType" => "application/vnd.google-apps.folder", "name" => "folder1"},
...

iex> 

```

See the [online documentation](https://hexdocs.pm/drivex).

## Installation

1. Add to your ```mix.exs``` file:

```elixir
def deps do
  [
    { :drivex, "~> 0.0.2" }
  ]
end
```

2. Create or select a project at [Google Drive API enabler wizard](https://console.developers.google.com/flows/enableapi?apiid=drive.googleapis.com). Click <b>Continue</b>. Click <b>Go to credentials</b>.

3. Select <b>Other non-UI</b>, Click <b>Application data</b>, Click <b>No, I have not used.</b>, Click <b>Required credentials</b>.

4. Input <b>Service account name</b>, Select <b>Porject - Owner</b>. Click <b>next</b>, Start download JSON automatically. Rename it to <b>client_secret.json</b> and move to ```config``` folder.

5. Click <b>Manage service accounts</b>, Edit service account, Click <b>Enable G Suite domain wide delegation</b>.

6. Browse <b>Google Drive</b> and set <b>Collaboration Settings</b> to any folder on add <b>service account id</b>(like xxx-xxx@xxxx.iam.gserviceaccount.com).

7. Add to your ```config.exs``` file:

```elixir
config :goth, 
  json: "./config/client_secret.json" |> File.read!
```

8. Input following, It's success when listed Google Drive folders & files.

```
mix desp.get
iex -S mix
iex> GoogleDrive.list()
%{"files" => [%{"id" => "1tDgypK1qrcg0oule4Cxxxxxxxy0L7CwN82G0JxC8",
  "kind" => "drive#file",
  "mimeType" => "application/vnd.google-apps.spreadsheet", "name" => "spreadsheet1"},
%{"id" => "0B8yV3717Z-lxxxxxxxxxDaVE", "kind" => "drive#file",
  "mimeType" => "application/vnd.google-apps.folder", "name" => "folder1"},
...
```

## License
This project is licensed under the terms of the Apache 2.0 license, see LICENSE.
