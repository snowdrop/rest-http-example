node("launchpad-maven") {
  checkout scm
  stage("Test") {
    sh "mvn verify -Popenshift,openshift-it"
  }
  stage("Deploy") {
    sh "mvn fabric8:deploy -Popenshift -DskipTests"
  }
}
