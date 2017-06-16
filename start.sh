#/bin/bash

cd zuada-api
ruby api.rb -o 0.0.0.0 &
cd ..
ng serve --host 10.32.112.136