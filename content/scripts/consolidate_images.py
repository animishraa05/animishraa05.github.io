import os
import re
import shutil

vault_root = '/home/ani/blog/content'
assets_dir = os.path.join(vault_root, 'assets')
os.makedirs(assets_dir, exist_ok=True)

image_extensions = {'.png', '.jpg', '.jpeg', '.gif', '.svg', '.webp'}

# Regex to find standard Markdown images `![alt](filename)` and Obsidian wiki images `![[filename]]`
# It captures the exact filename inside the link.
# Examples: 
# ![](image.png) -> match 'image.png'
# ![alt text](image.png) -> match 'image.png'
# ![[image.png]] -> match 'image.png'
# ![[image.png|100]] -> match 'image.png'
link_pattern = re.compile(r'!\[.*?\]\(([^)]+)\)|!\[\[([^]|]+)(?:\|[^]]+)?\]\]')

def get_unique_name(base_name, parent_dir_name):
    # Try to prefix with parent directory name for uniqueness
    name, ext = os.path.splitext(base_name)
    if parent_dir_name:
        new_name = f"{parent_dir_name}_{name}{ext}"
    else:
        new_name = base_name
        
    final_name = new_name
    counter = 1
    while os.path.exists(os.path.join(assets_dir, final_name)):
        if final_name == base_name: # if it's already the exact same file being processed, skip
            pass
        final_name = f"{os.path.splitext(new_name)[0]}_{counter}{ext}"
        counter += 1
    return final_name

processed_images = {} # old_path -> new_name

# First pass: find all images, move them, and record their new names
for root, dirs, files in os.walk(vault_root):
    if 'assets' in root.split(os.sep) or '.git' in root.split(os.sep):
        continue
    
    parent_dir_name = os.path.basename(root)
    
    for file in files:
        ext = os.path.splitext(file)[1].lower()
        if ext in image_extensions:
            old_path = os.path.join(root, file)
            new_name = get_unique_name(file, parent_dir_name)
            new_path = os.path.join(assets_dir, new_name)
            
            # Move the file
            shutil.move(old_path, new_path)
            processed_images[old_path] = new_name
            print(f"Moved: {old_path} -> {new_path}")

# Second pass: update markdown files
for root, dirs, files in os.walk(vault_root):
    if '.git' in root.split(os.sep):
        continue
        
    for file in files:
        if file.endswith('.md'):
            md_path = os.path.join(root, file)
            with open(md_path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            original_content = content
            
            # Find all image links
            def replacer(match):
                # match.group(1) is for standard links, match.group(2) is for wiki links
                filename_in_link = match.group(1) or match.group(2)
                
                # Check if this filename corresponds to any image we moved from THIS directory
                # or just any image we moved.
                # In Obsidian, it usually refers to the image in the same directory if it existed.
                potential_old_path = os.path.join(root, filename_in_link)
                # But it could also just be a filename without path.
                # Let's search if we have processed it from this directory
                
                if potential_old_path in processed_images:
                    new_name = processed_images[potential_old_path]
                    # We just replace the filename in the match
                    if match.group(1): # Standard link
                        return match.group(0).replace(match.group(1), new_name)
                    else: # Wiki link
                        return match.group(0).replace(match.group(2), new_name)
                
                # If we didn't find it in the same directory, check if it was moved from SOMEWHERE
                # but only if the filename in link is just a basename
                if os.path.basename(filename_in_link) == filename_in_link:
                    for old_p, new_n in processed_images.items():
                        if os.path.basename(old_p) == filename_in_link:
                            if match.group(1):
                                return match.group(0).replace(match.group(1), new_n)
                            else:
                                return match.group(0).replace(match.group(2), new_n)
                
                return match.group(0) # no change

            new_content = link_pattern.sub(replacer, content)
            
            if new_content != original_content:
                with open(md_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Updated links in: {md_path}")
