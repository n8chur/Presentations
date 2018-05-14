task :validate_version do
    eval(`arc paste P142`)
end

task :clean do
    sh("rm -rf #{DERIVED_DATA_DIR}/*")
end

task :bootstrap do
    # Bootstrap, downloading prebuilt frameworks from a cache if available.
    eval(`arc paste P299`)
end

task :test do
    sh("#{BUILD_TOOL} test #{BUILD_FLAGS_TEST} | #{PRETTIFY}")
end

task :coverage do
    ENV['BUILD_SETTINGS'] = `#{BUILD_TOOL} test #{BUILD_FLAGS_TEST} -showBuildSettings`

    eval(`arc paste P226`)
end

task :build_example do
    sh("#{BUILD_TOOL} build #{BUILD_FLAGS_EXAMPLE} | #{PRETTIFY}")
end

task :archive do
    # Used by P299
    CARTHAGE_NO_SKIP_CURRENT = true

    # Bootstrap, downloading prebuilt frameworks from a cache if available.
    eval(`arc paste P299`)

    sh("carthage archive #{LIBRARY_NAME} --output #{ARCHIVE_PATH}")
end

task :increment_version do
    eval(`arc paste P142`)
end

task :upload_archive do
    ENV['GITHUB_REPO'] = "Automatic/#{LIBRARY_NAME}"
    ENV['ARCHIVE_PATH'] = ARCHIVE_PATH

    eval(`arc paste P148`)
end

task :diff => [
    :validate_version,
    :clean,
    :archive,
    :test,
    :coverage,
    :build_example,
]

task :ci => [
    :clean,
    :archive,
    :test,
    :coverage,
    :build_example,
    :increment_version,
    :upload_archive,
]

private

# Xcodebuild

LIBRARY_NAME = 'AUTPresentations'
EXAMPLE_SCHEME = 'Example'
TEST_SDK = 'iphonesimulator'
DERIVED_DATA_DIR = "#{ENV['HOME']}/Library/Developer/Xcode/DerivedData"
BUILD_TOOL = 'xcodebuild'

# Use iPhone 5 & 6 to test both 32 and 64 bits architectures
BUILD_FLAGS_TEST =
    "-scheme '#{LIBRARY_NAME}' "\
    "-destination 'platform=iOS Simulator,name=iPhone 8' "\
    "-enableCodeCoverage YES "\
    "-sdk #{TEST_SDK}"

BUILD_FLAGS_EXAMPLE =
    "-scheme #{EXAMPLE_SCHEME} "\
    "-destination 'platform=iOS Simulator,name=iPhone 8' "\
    "-sdk #{TEST_SDK}"

PRETTIFY = "xcpretty; exit ${PIPESTATUS[0]}"

# Carthage

PRODUCT_NAME = "#{LIBRARY_NAME}.framework"
ARCHIVE_PATH = "#{PRODUCT_NAME}.zip"
