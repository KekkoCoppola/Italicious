import re
import os

def process_file(in_path, out_path, submit_dest, auth_link_old, auth_link_new, brand_href_old):
    try:
        with open(in_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except UnicodeDecodeError:
        with open(in_path, 'r', encoding='cp1252') as f:
            content = f.read()
    
    # Remove JSP <% ... %> blocks
    content = re.sub(r'<%[\s\S]*?%>', '', content)
    
    # Replace forms functionality
    content = re.sub(r'action="[^"]+"', f'onsubmit="event.preventDefault(); window.location.href=\'{submit_dest}\';"', content)
    
    # Specific links
    content = content.replace(f'href="{auth_link_old}"', f'href="{auth_link_new}"')
    content = content.replace(f'href="{brand_href_old}"', 'href="index.html"')
    content = content.replace('href="<%=request.getContextPath() %>/home"', 'href="index.html"')
    
    # Ensure banner isn't lost if applied later, or just clean it up 
    
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write(content)

base_dir = r"c:\Users\Master\Documents\GitHub\Italicious"
process_file(
    os.path.join(base_dir, 'src/main/webapp/Login.jsp'), 
    os.path.join(base_dir, 'docs/login.html'), 
    'index.html', 
    'register', 
    'register.html', 
    '<%=request.getContextPath() %>/home'
)
process_file(
    os.path.join(base_dir, 'src/main/webapp/register.jsp'), 
    os.path.join(base_dir, 'docs/register.html'), 
    'login.html', 
    'login', 
    'login.html', 
    '/Italicious/home'
)
