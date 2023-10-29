git clone --bare git@github.com:mark-a-austin/.dotfiles.git $HOME/.dotfiles
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | grep -E "\s+\." | awk "{ print $1 }" | xargs -I {} dirname {} | xargs -I{} mkdir -p .dotfiles-backup/{};
    config checkout 2>&1 | grep -E "\s+\." | awk "{ print $1 }" | xargs -I{} mv {} .dotfiles-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
#rm $HOME/README.md $HOME/LICENSE $HOME/Brewfile
