import os
import re
import warnings
import json





def get_cmake_file() -> list:
	fnames = []
	try:
		file_tree = os.walk(os.path.curdir)
		for ft_dir, _, ft_names in file_tree:
			for fn in ft_names:
				if "CMakeLists.txt" != fn:
					continue
				fnames.append(f"{ft_dir}/{fn}")
	except Exception as e:
		print("Failed to walk os.path.curdir()")
		print(e)				
	return fnames


def extract_cmakefile_content(cmake_files: list) -> dict:
	cmake_file_contents = {}
	for cmf in cmake_files:
		if not os.path.exists(cmf):
			warnings.warn(f"File could not be found: {cmf}")
			continue
		with open(cmf, 'r') as f:
			try:
				cmake_file_contents[cmf] = f.read()
			except Exception as e:
				print(e)
	return cmake_file_contents



def extract_targets(cmake_content: str) -> list:
    no_comments = re.sub(r'#.*', '', cmake_content)
    pattern = r'add_(executable|library)\s*\(\s*([^\s\)]+)'
    matches = re.findall(pattern, no_comments, re.IGNORECASE)
    return matches



def gather_targets(cmake_file_contents: dict) -> dict:
	targets = {}
	for path, content in cmake_file_contents.items():
		trgt = extract_targets(content)
		if trgt:
			targets[path] =trgt
	return targets



def save_to_file(fname: str, lib_dict: dict):
	if os.path.exists(fname):
		print(f"{fname} already exists!")
		confirm = input(f"Overwrite {fname} (Y/n): ")
		if confirm not in ("n","N","y","Y"):
			print("Invalid entry.")
			return
		if confirm == "n" or confirm == "N":
			print("Exiting...")
			return

	with open(fname, "w") as file:
		json.dump(lib_dict, file, indent=2)
	print(f"File saved to {fname}.")



def main(file_name):
	cmake_files = get_cmake_file()
	cmake_file_contents = extract_cmakefile_content(cmake_files)
	target_dict = gather_targets(cmake_file_contents)
	save_to_file(file_name, target_dict)


if __name__ == "__main__":
	file_name = "litertlm_targets.json"
	main(file_name)


