import os
import sys
import subprocess
import shutil

EVG_VARIANTS = ["winter", "fall", "spring", "summer"]


def main(input_dir, output_dir, input_variant=None):
    for variant in EVG_VARIANTS:
        if input_variant and input_variant != variant:
            continue
        # for every file in the input directory and its subdirectories
        for root, dirs, files in os.walk(input_dir):
            for file in files:
                if any(file.endswith(ext) for ext in [
                    "jpg",
                    "jpeg",
                    "png",
                    "gif"
                ]):
                    input_path = os.path.join(root, file)
                    # print("input_path: " + input_path)
                    relative_path = os.path.relpath(input_path, input_dir)
                    output_path = os.path.join(
                        output_dir,
                        variant,
                        relative_path
                    )
                    # print("output_path: " + output_path)
                    lutgen(
                        [input_path],
                        output_path=output_path,
                        palette=f'evergarden-{variant}',
                        level=16
                    )
    if input_variant == "unthemed" or input_variant is None:
        shutil.copytree(input_dir, os.path.join(output_dir, "unthemed"))


def run_lutgen(command):
    command.insert(0, 'lutgen')
    try:
        print("[lutgen] running command: ", command)
        result = subprocess.run(
            command,
            check=True,
            text=True,
            capture_output=True
        )
        print("[lutgen] output: ", result.stdout)
    except subprocess.CalledProcessError as e:
        print("[lutgen] error: ", e.stderr)
        sys.exit(e.returncode)


def generate_lut(palette, level, lut_file):
    command = ['generate', '-o', lut_file]
    # lut args
    args = []
    args.append('-G')
    args.append('-i=16')
    args.append('-m=8')
    args.append(f'--level={level}')
    command.extend(args)
    palette_file = os.path.join("palettes", palette)
    file = open(palette_file, "r")
    colors = file.read()
    file.close()
    command.append('--')
    command.extend([color for color in colors.split('\n') if color != ""])
    run_lutgen(command)


def lutgen(images, output_path=None, palette=None, level=16):
    command = ['apply', '-d']
    if palette:
        lut_file = f'{palette}.png'
        command.extend(['--hald-clut', lut_file])
        if not os.path.exists(lut_file):
            generate_lut(palette, level, lut_file)
    if output_path:
        command.append(f'--output={output_path}')
    command.extend(images)
    run_lutgen(command)


if __name__ == "__main__":
    if len(sys.argv) < 3 or len(sys.argv) > 4:
        print("usage: python lutgen.py <input_dir> <output_dir> [variant]")
        sys.exit(1)

    input_dir = sys.argv[1]
    output_dir = sys.argv[2]
    variant = sys.argv[3] if len(sys.argv) == 4 else None

    main(input_dir, output_dir, variant)
