local home_dir = os.getenv("HOME")

return {
  home_dir = home_dir,
  ansible_dir = home_dir .. '/MEGA/ansible/'
}
