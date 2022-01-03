defmodule PocGitHooks.Repo do
  use Ecto.Repo,
    otp_app: :poc_git_hooks,
    adapter: Ecto.Adapters.Postgres
end
