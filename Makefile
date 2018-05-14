NAME = AUTPresentations
PROJECT_NAME = ${NAME}.xcodeproj
SCHEME_NAME = ${NAME}
EXAMPLE_SCHEME_NAME = Example

SIMULATOR = iphonesimulator11.3

.PHONY: bootstrap test

bootstrap:
	@carthage bootstrap --platform ios

test:
	# Ensure the example builds
	@xcodebuild build \
		-scheme ${EXAMPLE_SCHEME_NAME} \
		-sdk ${SIMULATOR}
	@xcodebuild \
		-project ${PROJECT_NAME} \
		-scheme ${SCHEME_NAME} \
		-sdk ${SIMULATOR} build-for-testing
	@xctool \
		-project ${PROJECT_NAME} \
		-scheme ${SCHEME_NAME} \
		run-tests \
		-test-sdk ${SIMULATOR}
