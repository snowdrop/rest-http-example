node("maven") {
  checkout scm
  stage("Build") {
    sh "mvn package"
  }
  stage("Deploy") {
    sh "mvn fabric8:deploy -Popenshift -DskipTests"
  }
}
