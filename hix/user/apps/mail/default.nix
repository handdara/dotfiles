{...}: let
    email = "brittain@sent.com";
in {
    programs.mbsync = {
        enable = true;
        groups = {
            inboxes = {
                account1 = ["Inbox"];
                account2 = ["Inbox"];
            };
        };
        extraConfig = ''
          # First section: remote IMAP account
          IMAPAccount fastmail
          Host imap.fastmail.com
          Port 993
          User ${email}
          # For simplicity, this is how to read the password from another file.
          # For better security you should use GPG https://gnupg.org/
          PassCmd "echo 'not done right now'"
          SSLType IMAPS
          SSLVersions TLSv1.2

          IMAPStore fastmail-remote
          Account fastmail

          # This section describes the local storage
          MaildirStore fastmail-local
          Path ~/Maildir/
          Inbox ~/Maildir/INBOX
          # The SubFolders option allows to represent all
          # IMAP subfolders as local subfolders
          SubFolders Verbatim

          # This section a "channel", a connection between remote and local
          Channel fastmail
          Master :fastmail-remote:
          Slave :fastmail-local:
          Patterns *
          Expunge None
          CopyArrivalDate yes
          Sync All
          Create Slave
          SyncState *
        '';
    };
    programs.neomutt = {
        enable = true;
    };
}
