defmodule Drivex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :drivex,
      version: "0.0.1",
      elixir: "~> 1.5",
		description: "Google Drive API Elixir wrapper library", 
		package: 
		[
			maintainers: [ "piacere-ex" ], 
			licenses:    [ "Apache 2.0" ], 
			links:       %{ "GitHub" => "https://github.com/piacere-ex/drivex" }, 
		],
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
	defp deps do
		[
			{ :ex_doc,              "~> 0.18.1", only: :dev, runtime: false }, 
			{ :earmark,             "~> 1.2.4",  only: :dev }, 
			{ :power_assert,        "~> 0.1.1",  only: :test }, 
			{ :mix_test_watch,      "~> 0.5.0",  only: :dev, runtime: false }, 
			{ :dialyxir,            "~> 0.5.1",  only: :dev }, 

			{ :smallex, "~> 0.0.6" }, 
			{ :goth,    "~> 0.7.2" }, 
		]
	end
end
