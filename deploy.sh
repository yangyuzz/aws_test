#!/bin/bash

# 1. env variable
source ./var.sh
echo "1. env variable setting complete"

# 2. cron delete
touch crontab_delete
crontab crontab_delete
rm crontab_delete
echo "2. cron delete complete"

# 3. server checking
if [ -n "${PROJECT_PID}" ]; then
  # re deploy
  kill -9 $PROJECT_PID
  echo "3. project kill complete"
else
  # first deploy
  # 3-1 apt update
  sudo apt-get -y update 1>/dev/null
  echo "3-1. apt update complete"
  
  # 3-2 jdk install
  sudo apt-get -y install openjdk-17-jdk 1>/dev/null
  echo "3-2. jdk install complete"
  
  # 3-3 timezone
  sudo timedatectl set-timezone Asia/Seoul
  echo "3-3. timezone setting complete"

  # 내가 깃에 프로젝트 zip 파일로 올려서 ;; 압축해제도 넣어야 함.
  sudo apt-get install zip unzip
  echo "install zip unzip complete!"
fi

# 4. project folder delete
rm -rf ${HOME}/${REPO_NAME}
echo "4. project folder delete complete"

# 5. git clone
git clone https://github.com/${GITHUB_ID}/${REPO_NAME}.git
sleep 3s
echo "5. git clone complete"

# zipped pjt in repo have to unzip
unzip ${HOME}/${REPO_NAME}/${PROJECT_NAME}.zip -d ${HOME}/${REPO_NAME}/${PROJECT_NAME}


# 6. gradlew +x
chmod u+x ${HOME}/${REPO_NAME}/${PROJECT_NAME}/gradlew
echo "6. gradlew u+x complete"

# 7. build
cd ${HOME}/${REPO_NAME}/${PROJECT_NAME}
./gradlew clean build
echo "7. gradlew build complete"

# 8. start jar
# nohup java -jar -Dspring.profiles.active=prod ${JAR_PATH} 1>${HOME}/log.out 2>${HOME}/err.out &
nohup java -jar ${JAR_PATH} &
echo "8. start server complete"

# 9. cron registration
# touch crontab_new
# echo "* * * * * ${HOME}/check-and-restart.sh" 1>>crontab_new
# register the others... you use >> (append)
# crontab crontab_new
# rm crontab_new
# echo "9. cron registration complete"
