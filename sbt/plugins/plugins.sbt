if (sys.props("java.version").startsWith("1.6"))
  addSbtPlugin("org.ensime" % "sbt-ensime" % "1.0.0")
else
  addSbtPlugin("org.ensime" % "sbt-ensime" % "1.10.0")

addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-M14")

resolvers ++= Seq(
  "Sonatype OSS Releases" at "https://oss.sonatype.org/content/repositories/releases/",
  "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots/"
)

addSbtPlugin("net.ceedubs" %% "sbt-ctags" % "0.2.0")
