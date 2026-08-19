import os

base_dir = '/home/ani/blog/content/Private'

def get_title(path):
    return os.path.basename(path).replace('-', ' ').title()

def generate_moc(directory):
    items = sorted(os.listdir(directory))
    
    subdirs = []
    md_files = []
    
    for item in items:
        # Skip hidden files/folders and the MOC itself
        if item.startswith('.') or item.endswith('_MOC.md'):
            continue
            
        full_path = os.path.join(directory, item)
        if os.path.isdir(full_path):
            subdirs.append(item)
        elif item.endswith('.md'):
            md_files.append(item)
            
    # If a directory has no subdirs and no md files (other than MOC), skip it
    if not subdirs and not md_files:
        return
        
    moc_path = os.path.join(directory, '_MOC.md')
    dir_name = os.path.basename(directory)
    if directory == base_dir:
        dir_name = "Private Vault"
        
    title = dir_name.replace('-', ' ').title()
    
    lines = []
    lines.append(f"---")
    lines.append(f"title: \"{title} MOC\"")
    lines.append(f"tags: [moc]")
    lines.append(f"---")
    lines.append(f"")
    lines.append(f"# 🗺️ {title} Map of Content")
    lines.append(f"Welcome to the syllabus and index for **{title}**.")
    lines.append(f"")
    
    if subdirs:
        lines.append(f"## 📁 Sub-Topics")
        for d in subdirs:
            d_title = d.replace('-', ' ').title()
            lines.append(f"- [[{d}/_MOC|{d_title}]]")
        lines.append(f"")
        
    if md_files:
        lines.append(f"## 📄 Notes")
        for f in md_files:
            if f == 'Daily Template.md':
                continue
            name = f[:-3] # remove .md
            lines.append(f"- [[{name}]]")
            
    with open(moc_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
        
    # Recursively generate MOCs for subdirectories
    for d in subdirs:
        generate_moc(os.path.join(directory, d))

# Start generation
generate_moc(base_dir)
print("MOCs generated successfully!")
