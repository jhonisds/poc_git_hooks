defmodule PocGitHooks.Lint.NoBoolCaseCheck do
  @moduledoc """
    Checa pelo uso de expressões `case` com uma variável booleana
    simples.
    O _style guide_ do projeto define que devemos usar um `if` nestes
    casos.
    Vide [o style guide, seção `case/if`](docs/style_guide.md#bool-case)
  """

  use Credo.Check,
    base_priority: :high,
    category: :readability,
    tags: [:poc_git_hooks]

  @explanation [
    check: @moduledoc
  ]

  @doc false
  def run(source_file, params \\ []) do
    # IssueMeta helps us pass down both the source_file and params of a check
    # run to the lower levels where issues are created, formatted and returned
    issue_meta = IssueMeta.for(source_file, params)

    Credo.Code.prewalk(source_file, &analyze(&1, &2, issue_meta))
  end

  defp analyze({:case, case_meta, [_, [do: clauses]]} = ast, issues, issue_meta) do
    check_for_bool_clauses(clauses, case_meta, ast, issues, issue_meta)
  end

  defp analyze({:case, case_meta, [[do: clauses]]} = ast, issues, issue_meta) do
    check_for_bool_clauses(clauses, case_meta, ast, issues, issue_meta)
  end

  defp analyze(ast, issues, _issue_meta) do
    {ast, issues}
  end

  defp check_for_bool_clauses(clauses, case_meta, ast, issues, issue_meta) do
    problems? =
      Enum.any?(
        clauses,
        &(match?({:->, _, [[true] | _]}, &1) or
            match?({:->, _, [[false] | _]}, &1))
      )

    if problems? do
      new_issue =
        issue_for(
          issue_meta,
          case_meta[:line]
        )

      {ast, [new_issue | issues]}
    else
      {ast, issues}
    end
  end

  defp issue_for(issue_meta, line_no) do
    # format_issue/2 is a function provided by Credo.Check to help us format the
    # found issue
    format_issue(issue_meta,
      message: "Use `if` when branching on simple boolean values instead of `case`",
      line_no: line_no
    )
  end
end
