# MIME Standard Applications Configuration
The XDG Specification enables a centralized and easy management of default applications.
These application are used by ``xdg-open`` and can be configured in ``../mimeapps.list``.

In order to keep the configuration well-encapsuled, general mime-configurations are used and specified in this directory in the corresponding ``.desktop``-files.
This results in an easy way to change e.g. the default text-editor.

Using `make` in this directory, the respective files are moved to `$HOME/.local/share/applications/`, where they update the default applications.

