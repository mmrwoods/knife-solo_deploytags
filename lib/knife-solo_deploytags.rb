require 'knife-solo_hooks'

Chef::Knife::SoloCook.before do
  if ! system("git diff HEAD --exit-code &> /dev/null")
    ui.warn "Local branch has uncommitted changes, chef run will not be tagged"
    @no_deploytags = true
  else
    `git fetch`
    local_branch ||= `git symbolic-ref -q HEAD`.sub(%r{^refs/heads/}, '').chomp
    remote_sha = `git log --pretty=format:%H origin/#{local_branch} -1`.chomp
    if ! system("git diff HEAD origin/#{local_branch} --exit-code > /dev/null")
      ui.warn "Local and remote branches have diverged, chef run will not be tagged"
      @no_deploytags = true
    end
  end
end

Chef::Knife::SoloCook.after do
  next if @no_deploytags
  git_user = `git config user.name`.chomp
  git_ref = `git log --abbrev-commit --oneline -n1 | cut -f1 -d' '`.chomp
  ui.msg "Tagging release of #{git_ref} to #{host}"
  # note: force option required as host without timestamp used as tag name
  `git tag -f -a #{host} -m \"#{git_user} released #{git_ref} to #{host}\" head`
  `git push -f origin #{host}`
end
