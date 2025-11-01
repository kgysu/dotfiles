# Pass functions

init-pass() {
  echo "Initialize pass"
  PUB_KEY="$HOME/.keys/pass/public.gpg"
  PRIV_KEY="$HOME/.keys/pass/private.gpg"

  echo "cloning repo.."
  git clone https://github.com/kgysu/pass ~/.password-store

  echo "import private key from: $PRIV_KEY"
  if [[ -f "$PRIV_KEY" ]]; then
    gpg --import "$PRIV_KEY"
  else
    echo "ERROR: no private key found: $PRIV_KEY"
    return
  fi


  echo "import public key from: $PUB_KEY"
  if [[ -f "$PUB_KEY" ]]; then
    gpg --import "$PUB_KEY"
  else
    echo "ERROR: no public key found: $PUB_KEY"
    return
  fi

  # get key fingerprint
  KEY_FPR=$(gpg --with-colons --import-options show-only --import "$PUB_KEY" | awk -F: '/^fpr:/ {print $10; exit}')
  if [[ -z "$KEY_FPR" ]]; then
    echo "ERROR: could not extract key fingerprint."
    return
  fi
  echo "set trust level on: $KEY_FPR"
  echo "$KEY_FPR:5:" | gpg --import-ownertrust

  echo "done!"
}


