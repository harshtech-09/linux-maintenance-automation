

````markdown
# 🐧 Linux Maintenance Automation

A practical Linux automation project built with **Bash Shell Scripting and Cron Jobs** to automate common system maintenance tasks such as log rotation, server backups, health checks, and scheduled maintenance.

The project focuses on reducing repetitive manual work by combining simple Linux commands and shell scripts into an automated workflow.

---

## 🚀 Project Overview

Managing Linux servers often involves repetitive tasks:

- Cleaning old log files
- Compressing logs
- Creating backups
- Removing outdated backups
- Checking system health
- Running maintenance tasks at specific times

Instead of performing these tasks manually, this project automates them using **Bash scripts + Cron**.

### 🔄 Automation Flow

```
                 Linux Server
                      │
                      ▼
              ┌───────────────┐
              │   Cron Jobs   │
              └───────┬───────┘
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
   Log Rotation    Backup     Health Check
          │           │           │
          └───────────┼───────────┘
                      ▼
             Maintenance Script
                      │
                      ▼
              Maintenance Logs
````

---

## 🛠️ Technologies & Tools

* **Linux**
* **Bash / Shell Scripting**
* **Cron / Crontab**
* `find`
* `gzip`
* `tar`
* `date`
* `du`
* `uptime`
* `df`
* Linux file permissions

---

# 📂 Project Structure

```text
linux-maintenance-automation/
│
├── backups.sh
├── health_check.sh
├── log_rotation.sh
├── maintenance.sh
└── cron-jobs.txt
└── README.md
```

---

# 🔹 1. Log Rotation

### Script

```text
log_rotation.sh
```

The log rotation script automates cleanup of old log files.

### What it does

* Checks whether the log directory exists
* Finds `.log` files older than 7 days
* Compresses old logs using `gzip`
* Finds compressed `.gz` files older than 30 days
* Deletes outdated compressed logs
* Displays execution status
* Exits with an error if the log directory doesn't exist

### Key command

```bash
find "$log_dir" -name "*.log" -mtime +7 -exec gzip {} \;
```

This finds log files older than 7 days and compresses them.

For cleanup:

```bash
find "$log_dir" -name "*.gz" -mtime +30 -delete
```

---

# 🔹 2. Automated Backup

### Script

```text
backups.sh
```

The backup script creates compressed and timestamped backups of a source directory.

### What it does

* Validates the source directory
* Creates the backup destination if required
* Generates a timestamp
* Creates a `.tar.gz` archive
* Verifies that the backup was created
* Displays the backup file and size
* Deletes backups older than 14 days

### Backup command

```bash
tar -czf "$backup_file" "$source_dir"
```

### Timestamp generation

```bash
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
```

### Backup cleanup

```bash
find "$destination_dir" -name "*.tar.gz" -mtime +14 -delete
```

---

# 🔹 3. Server Health Check

### Script

```text
health_check.sh
```

A simple Bash script that collects basic system information.

### It checks

* Current date
* Hostname
* System uptime
* Disk usage

### Commands used

```bash
date
hostname
uptime
df -h /
```

This provides a quick overview of the system's current state.

---

# 🔹 4. Scheduled Maintenance

### Script

```text
maintenance.sh
```

This script brings the automation together.

It:

1. Creates a maintenance log
2. Records the start time
3. Runs log rotation
4. Runs the backup process
5. Captures command output and errors
6. Records the completion time

### Output logging

```bash
>> "$log_file" 2>&1
```

This redirects both:

* Standard output
* Error output

into the maintenance log.

---

# ⏰ Cron Scheduling

Cron is used to execute the scripts automatically at predefined times.

### Cron Syntax

```text
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of Week (0-6)
│ │ │ └──── Month (1-12)
│ │ └────── Day of Month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

---

## 📅 Cron Jobs Used

### Log Rotation

Runs every day at **2:00 AM**.

```cron
0 2 * * * /path/to/log_rotate.sh
```

### Backup

Runs every **Sunday at 3:00 AM**.

```cron
0 3 * * 0 /path/to/backup.sh
```

### Health Check

Runs every **5 minutes**.

```cron
*/5 * * * * /path/to/health_check.sh
```

### Maintenance

Runs every day at **1:00 AM**.

```cron
0 1 * * * /path/to/maintenance.sh
```

---

# ⚙️ Setup & Usage

## 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/linux-maintenance-automation.git
```

```bash
cd linux-maintenance-automation
```

---

## 2. Make scripts executable

```bash
chmod +x backups.sh health_check.sh log_rotation.sh maintenance.sh
```

Verify permissions:

```bash
ls -l
```

---

## 3. Test the scripts manually

Before scheduling them with Cron, test each script individually.

### Log rotation

```bash
./log_rotation.sh
```

### Backup

```bash
./backups.sh
```

### Health check

```bash
./health_check.sh
```

### Maintenance

```bash
./maintenance.sh
```

---

# 🕐 Configure Cron

Open the user's crontab:

```bash
crontab -e
```

Add your required jobs:

```cron
0 2 * * * /absolute/path/to/log_rotation.sh
0 3 * * 0 /absolute/path/to/backups.sh
*/5 * * * * /absolute/path/to/health_check.sh
0 1 * * * /absolute/path/to/maintenance.sh
```

Check scheduled jobs:

```bash
crontab -l
```

---

# 🔍 Useful Commands

| Command      | Purpose                        |
| ------------ | ------------------------------ |
| `chmod +x`   | Make scripts executable        |
| `find`       | Find files based on conditions |
| `gzip`       | Compress files                 |
| `tar`        | Create archives                |
| `date`       | Generate timestamps            |
| `du -h`      | Check file/directory size      |
| `df -h`      | Check disk usage               |
| `uptime`     | Check system uptime            |
| `crontab -e` | Edit scheduled jobs            |
| `crontab -l` | List scheduled jobs            |
| `crontab -r` | Remove user's cron jobs        |

---

# 🧪 Testing

The scripts were tested manually before configuring the Cron schedules.

### Check executable permissions

```bash
ls -l
```

### Check Cron configuration

```bash
crontab -l
```

### Monitor maintenance logs

```bash
cat maintenance.log
```

or:

```bash
tail -f maintenance.log
```

---

# 📌 Important Notes

### Use absolute paths

Cron runs with a different environment than your interactive terminal, so using absolute paths makes scripts more reliable.

Example:

```bash
/home/user/project/scripts/backup.sh
```

instead of:

```bash
./backup.sh
```

### Test before scheduling

Always run scripts manually first and verify their output before adding them to Cron.

### Redirect output

For scheduled jobs, logging output is useful for troubleshooting:

```bash
/path/to/script.sh >> /path/to/script.log 2>&1
```

---

# 🎯 What I Learned

This project helped me understand how individual Linux commands can be combined into practical automation.

### Key concepts practiced

* Bash scripting
* Variables
* Functions
* Conditional statements
* Command substitution
* File handling
* Error handling
* Exit codes
* `find`
* `tar`
* `gzip`
* Linux permissions
* Cron scheduling
* Output redirection
* Basic system monitoring

The biggest takeaway:

> **Shell scripting isn't just about writing commands. It's about removing repetitive work through automation.**

---

# 🚀 Future Improvements

Some possible improvements for this project:

* Add email/Slack notifications
* Add better error handling
* Add backup verification using checksums
* Store configuration separately
* Add logging with log levels
* Add disk-space alerts
* Run the automation on a cloud VM
* Integrate the scripts into a CI/CD workflow

---

## 👨‍💻 Author

**Harshad**

Learning and building with:

**Linux • Shell Scripting • DevOps • Cloud • Automation**

---

⭐ If you find this project useful, feel free to explore the code and give the repository a star!

````
