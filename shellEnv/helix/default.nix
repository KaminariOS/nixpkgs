{
  lib,
  pkgs,
  ...
} @ args: {
  programs.helix = {
    enable = true;

    settings = {
      theme = lib.mkDefault "catppuccin_mocha";
      editor = {
        true-color = true;
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
      };

      keys.normal = {
        # Quick iteration on config changes
        C-o = ":config-open";
        C-r = ":config-reload";

        # Some nice Helix stuff
        C-h = "select_prev_sibling";
        C-j = "shrink_selection";
        C-k = "expand_selection";
        C-l = "select_next_sibling";

        # Personal preference
        o = ["open_below" "normal_mode"];
        O = ["open_above" "normal_mode"];

        # Muscle memory
        "{" = ["goto_prev_paragraph" "collapse_selection"];
        "}" = ["goto_next_paragraph" "collapse_selection"];
        "0" = "goto_line_start";
        "$" = "goto_line_end";
        "^" = "goto_first_nonwhitespace";
        G = "goto_file_end";
        "%" = "match_brackets";
        V = ["select_mode" "extend_to_line_bounds"];
        C = ["collapse_selection" "extend_to_line_end" "change_selection"]; # Requires https://github.com/helix-editor/helix/issues/2051#issuecomment-1140358950
        D = ["extend_to_line_end" "delete_selection"];
        S = "surround_add"; # Would be nice to be able to do something after this but it isn't chainable

        # Extend and select commands that expect a manual input can't be chained
        # I've kept d[X] commands here because it's better to at least have the stuff you want to delete
        # selected so that it's just a keystroke away to delete
        d = {
          d = ["extend_to_line_bounds" "delete_selection"];
          t = ["extend_till_char"];
          s = ["surround_delete"];
          i = ["select_textobject_inner"];
          a = ["select_textobject_around"];
        };

        # Clipboards over registers ye ye
        x = "delete_selection";
        p = "paste_clipboard_after";
        P = "paste_clipboard_before";
        # Would be nice to add ya and yi, but the surround commands can't be chained
        y = ["yank_main_selection_to_clipboard" "normal_mode" "flip_selections" "collapse_selection"];
        Y = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "goto_line_start" "collapse_selection"];

        # Uncanny valley stuff, this makes w and b behave as they do Vim
        w = ["move_next_word_start" "move_char_right" "collapse_selection"];
        e = ["move_next_word_end" "collapse_selection"];
        b = ["move_prev_word_start" "collapse_selection"];

        # If you want to keep the selection-while-moving behaviour of Helix, this two lines will help a lot,
        # especially if you find having text remain selected while you have switched to insert or append mode
        #
        # There is no real difference if you have overriden the commands bound to 'w', 'e' and 'b' like above
        # But if you really want to get familiar with the Helix way of selecting-while-moving, comment the
        # bindings for 'w', 'e', and 'b' out and leave the bindings for 'i' and 'a' active below. A world of difference!
        i = ["insert_mode" "collapse_selection"]; # Requires https://github.com/helix-editor/helix/issues/2052#issuecomment-1140358950
        a = ["append_mode" "collapse_selection"]; # Requires https://github.com/helix-editor/helix/issues/2052#issuecomment-1140358950

        # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
        esc = ["collapse_selection" "keep_primary_selection"];
      };
      keys.insert = {
        # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
        esc = ["collapse_selection" "normal_mode"];
      };
      keys.select = {
        # Muscle memory
        "{" = ["extend_to_line_bounds" "goto_prev_paragraph"];
        "}" = ["extend_to_line_bounds" "goto_next_paragraph"];
        "0" = "goto_line_start";
        "$" = "goto_line_end";
        "^" = "goto_first_nonwhitespace";
        G = "goto_file_end";
        D = ["extend_to_line_bounds" "delete_selection" "normal_mode"];
        C = ["goto_line_start" "extend_to_line_bounds" "change_selection"];
        "%" = "match_brackets";
        S = "surround_add"; # Basically 99% of what I use vim-surround for

        # Visual-mode specific muscle memory
        i = "select_textobject_inner";
        a = "select_textobject_around";

        # Some extra binds to allow us to insert/append in select mode because it's nice with multiple cursors
        tab = ["insert_mode" "collapse_selection"]; # tab is read by most terminal editors as "C-i"
        C-a = ["append_mode" "collapse_selection"];

        # Make selecting lines in visual mode behave sensibly
        k = ["extend_line_up" "extend_to_line_bounds"];
        j = ["extend_line_down" "extend_to_line_bounds"];

        # Clipboards over registers ye ye
        d = ["yank_main_selection_to_clipboard" "delete_selection"];
        x = ["yank_main_selection_to_clipboard" "delete_selection"];
        y = ["yank_main_selection_to_clipboard" "normal_mode" "flip_selections" "collapse_selection"];
        Y = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "goto_line_start" "collapse_selection" "normal_mode"];
        p = "replace_selections_with_clipboard"; # No life without this
        P = "paste_clipboard_before";

        # Escape the madness! No more fighting with the cursor! Or with multiple cursors!
        esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
        }
        {
          name = "cpp";
        }
        {
          name = "bash";
        }
        {
          name = "c";
        }
        {
          name = "css";
        }
        {
          name = "glsl";
        }
        {
          name = "git-ignore";
        }
        {
          name = "glsl";
        }
        {
          name = "go";
        }
        {
          name = "html";
        }
        {
          name = "java";
        }
        {
          name = "javascript";
        }
        {
          name = "json";
        }
        {
          name = "make";
        }
        {
          name = "markdown";
        }
        {
          name = "nasm";
        }
        {
          name = "regex";
        }
        {
          name = "rust";
        }
        {
          name = "wgsl";
        }
        {
          name = "toml";
        }
        {
          name = "yaml";
        }
      ];
    };
  };
}
