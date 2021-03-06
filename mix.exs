defmodule TicTacToe.MixProject do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe_math3v,
      version: "1.0.2",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
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
    [{:ex_doc, "~> 0.16", only: :dev, runtime: false}]
  end

  defp description() do
    "TicTacToe Application to learn OTP and Elixir."
  end

  defp package() do
    [
      maintainers: ["Matej Minarik"],
      licenses: ["MIT"],
      files: ["lib", "mix.exs", "README*"],
      links: %{"GitHub" => "https://github.com/Math3v/tic_tac_toe_otp"}
    ]
  end
end
