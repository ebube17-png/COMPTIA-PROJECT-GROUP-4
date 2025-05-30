# Group 4 COMPTIA Project
**Purpose**: A SYSTEM ADMINISTRATIVE DASHBOARD



# Bash Simple Courses

[![Documentation Status](https://readthedocs.org/projects/bashsimplecourses/badge/?version=master)](https://bashsimplecurses.readthedocs.io/en/master/?badge=master)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmetal3d%2Fbashsimplecurses.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmetal3d%2Fbashsimplecurses?ref=badge_shield)
                

Bash Simple Courses gives you some basic functions to quickly create windows on your terminal.

An example is given: bashbar. Bashbar is a monitoring bar that you can integrate into tiling window managers.

The (unfinished) goal of Bash Simple Curses is to create windows. It is only intended to create colored windows and display information into. But, [with a little tips](https://bashsimplecurses.readthedocs.io/en/master/tips/), you can also make it interactive.

To use this library, you have to import `simple_courses.sh` into your bash script, like so:

```bash

#!/bin/bash

# import library, please check path
#source /usr/lib/simple_curses.sh
source /usr/local/lib/simple_courses.sh

# You must create a "main" function:
main () {
    # Your code here, here we add some windows and text
    window "title" "color"
    append "Text..."
    endwin
}

# Then, execute the loop every second ( -t 1 => 1s)
main_loop -t 1
```

That's all.


## Example

```bash
#!/bin/bash
source simple_courses.sh

main(){
    # create a window
    window "Example" "blue" "50%"
        append "Hello world"
        addsep
        append "The date command"
        append_command "date"
    endwin

    # move on the next column
    col_right

    # and create another window
    window "Example 2" "red" "50%"
        append "Hello world"
        addsep
        append "The date command"
        append_command "date"
    endwin
}
main_loop
```

![Simple example](docs/images/bsc-example.png)


## Install

There are several possibilities to use the library. We recommend to copy `simple_curses.sh` inside your project and to "source" it.

But, if you want to make it available for the entire system, or for local user, you can use the `make install` command:

```bash
# install inside the system
# in /usr/local/lib
sudo make install

# for local user, no need to use sudo, but change the PREFIX
make install PREFIX=~/.local/lib
```

You can then uninstall the library file:

```bash
sudo make uninstall
make uninstall PREFIX=~/.local/bin
```

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fmetal3d%2Fbashsimplecurses.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fmetal3d%2Fbashsimplecurses?ref=badge_large)# COMPTIA Project Group 4


## ADMIN DASHBOARD

#!/bin/bash
# ADMIN DASHBOARD LAUNCHER
# Provides sudo access to the main system management interface

if [ "$ (id -u)" -ne 0 ]; then
    echo "Restarting with sudo..."
    exec sudo "$0 "$@
fi

exec ./main.sh


# **📚 Ultimate User Guide: System Management Dashboard**

## **🌍 Introduction**
This guide explains everything about the **System Management Dashboard** - from basic usage to advanced contribution, in simple terms anyone can understand.

---

## **🛠️ 1. What This Tool Does**
A **command-line control panel** that lets you manage your Linux system without memorizing complex commands. It's like having a:

- 🩺 **Computer doctor** (system info)
- 👮 **User manager** (add/remove people)
- 🔍 **Activity monitor** (running programs)
- 🌐 **Network inspector** (internet connections)
- 🛠️ **Service controller** (start/stop apps)
- 🔄 **Update installer** (software updates)
- 📜 **Logbook viewer** (system messages)
- 💾 **File backup tool** (save/restore data)

---

## **🚀 2. Getting Started**

### **📥 Installation**
```bash
git clone https://github.com/your-team/system-management-scripts.git
cd system-management-scripts
chmod +x *.sh utils/*.sh modules/*.sh
```

### **🏃 Running It**
```bash
./admin_dashboard.sh
```
*(Automatically asks for admin password if needed)*

---

## **🖥️ 3. Understanding the Dashboard**

### **🔢 Main Menu Options**
| #  | Option               | What It Does                          |
|----|----------------------|---------------------------------------|
| 0  | System Information   | Shows CPU, RAM, disk stats            |
| 1  | User Management      | Add/remove users, change passwords    |
| 2  | Process Management   | View/kill running programs            |
| 3  | Network Management   | Check internet/network settings       |
| 4  | Service Management   | Start/stop system services            |
| 5  | Update Management    | Install software updates              |
| 6  | Log Management       | Read system messages                  |
| 7  | Backup Management    | Save/restore important files          |
| 8  | Exit                 | Closes the dashboard                  |

---

## **🔍 4. How the Code Works (Simplified)**

### **📂 File Structure**
```
system-management-scripts/
├── 🚀 admin_dashboard.sh   # Starts everything (needs admin)
├── 🏠 main.sh              # Shows the main menu
├── 🧰 utils/               # Helper tools:
│   ├── 📝 log.sh           # Keeps records of actions
│   ├── ⌨️ userInput.sh     # Handles menus & typing
│   └── 📜 list_string.sh   # Formats lists nicely
└── ⚙️ modules/            # All the tools:
    ├── 💾 backup_managment.sh    # Backup files
    ├── 📜 log_managment.sh       # Read logs
    ├── 🌐 network_managment.sh   # Network tools
    ├── 🔄 process_managment.sh   # Manage apps
    ├── ⚙️ service_managment.sh   # Control services
    ├── 💻 system_information.sh  # System health
    ├── 🔄 update_managment.sh    # Update software
    └── 👥 user_managment.sh      # User accounts
```

### **🔄 How Data Flows**
1. You run `admin_dashboard.sh` (the boss)
2. It starts `main.sh` (the receptionist)
3. You choose an option (like "Process Management")
4. `main.sh` calls the right module (`process_managment.sh`)
5. The module does its job and reports back
6. `log.sh` writes down what happened

---

## **👨‍💻 5. For Team Members: How to Contribute**

### **🔄 Workflow Steps**
1. **Fork the repo** (Make your copy on GitHub)
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR-NAME/system-management-scripts.git
   ```
3. **Create a branch**:
   ```bash
   git checkout -b fix-network-bug
   ```
4. **Make changes** (edit files)
5. **Test your changes**:
   ```bash
   ./admin_dashboard.sh
   ```
6. **Commit & push**:
   ```bash
   git add .
   git commit -m "Fixed network display bug"
   git push origin fix-network-bug
   ```
7. **Create Pull Request** (Ask to add your changes)

### **📜 Team Rules**
- ✅ **1 person per script** (avoid conflicts)
- ✅ **Test before pushing**
- ✅ **Write clear commit messages**
- ❌ **Never push directly to main branch**
- ❌ **Don't modify others' code without asking**

---

## **🚨 6. Troubleshooting**

### **Common Issues**
| Problem | Solution |
|---------|----------|
| "Permission denied" | Run `chmod +x *.sh utils/*.sh modules/*.sh` |
| Menu looks broken | Make terminal window wider |
| Script won't run | Check you're using Linux/Mac (not Windows CMD) |
| Can't kill process | Try running with sudo: `sudo ./admin_dashboard.sh` |

### **Checking Logs**
```bash
cat ./log/system_admin.log  # View all logs
tail -f ./log/system_admin.log  # Watch live updates
```

---

## **🔮 7. Future Improvements**
- 📱 Mobile-friendly version
- 🌈 Colorful menus
- 🔄 Auto-update feature
- 🗂️ Better backup scheduling
- 🛡️ More security checks

---

## **📝 8. Quick Reference**

### **Essential Commands**
```bash
# Run the dashboard
./admin_dashboard.sh

# Check script permissions
ls -la *.sh

# View system info directly
bash ./modules/system_information.sh

# Search logs for errors
grep "ERROR" ./log/system_admin.log
```

### **Keyboard Shortcuts**
| Key | Action |
|-----|--------|
| Ctrl+C | Cancel current operation |
| Arrow Keys | Navigate menus |
| Enter | Confirm selection |
| Q | Quit most screens |

---

## **🎉 Conclusion**
Now you're ready to:
- 🖥️ **Use** the dashboard like a pro
- 🔧 **Understand** how it works
- 👥 **Contribute** improvements
- 🐛 **Fix** issues when they appear

**Happy system managing!** 🚀

*(Team leads: Print this guide or save as `USER_GUIDE.md` in your repo!)*



