project_root := justfile_directory()
src_dir := project_root / "src"

format:
	swiftformat "{{ project_root }}"

lint:
	swiftlint "{{ project_root }}"
