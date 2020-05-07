# Defined in - @ line 1
function ll --wraps='ls -la' --wraps=ls --description 'alias ll=ls -la'
  ls -la $argv;
end
