#!/usr/bin/env python3

import gi
gi.require_version("Gtk", "3.0")
gi.require_version("GtkLayerShell", "0.1")
gi.require_version("GdkPixbuf", "2.0")

from gi.repository import Gtk, Gdk, GLib, GtkLayerShell, GdkPixbuf
import sys
import signal
import os
from PIL import Image, ImageSequence

class FloatingWidget(Gtk.Window):
    def __init__(self, gif_path):
        super().__init__(type=Gtk.WindowType.TOPLEVEL)
        
        self.set_type_hint(Gdk.WindowTypeHint.DOCK)
        self.set_app_paintable(True)
        self.set_decorated(False)
        self.set_skip_taskbar_hint(True)
        self.set_skip_pager_hint(True)
        self.set_keep_above(True)
        self.set_accept_focus(False)
        
        screen = self.get_screen()
        rgba = screen.get_rgba_visual()
        if rgba:
            self.set_visual(rgba)
        
        GtkLayerShell.init_for_window(self)
        GtkLayerShell.set_layer(self, GtkLayerShell.Layer.OVERLAY)
        GtkLayerShell.set_keyboard_mode(self, GtkLayerShell.KeyboardMode.NONE)
        GtkLayerShell.set_namespace(self, "floating-gif-widget")
        
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.TOP, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.LEFT, True)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.BOTTOM, False)
        GtkLayerShell.set_anchor(self, GtkLayerShell.Edge.RIGHT, False)
        
        display = Gdk.Display.get_default()
        self.screen_width = 0
        self.screen_height = 0
        n_monitors = display.get_n_monitors()
        for i in range(n_monitors):
            monitor = display.get_monitor(i)
            geom = monitor.get_geometry()
            self.screen_width = max(self.screen_width, geom.x + geom.width)
            self.screen_height = max(self.screen_height, geom.y + geom.height)
        if self.screen_width == 0 or self.screen_height == 0:
            self.screen_width = 1920
            self.screen_height = 1080
        
        try:
            self.gif = Image.open(gif_path)
            self.frames = []
            for frame in ImageSequence.Iterator(self.gif):
                rgba = frame.convert("RGBA")
                data = rgba.tobytes()
                w, h = rgba.size
                pixbuf = GdkPixbuf.Pixbuf.new_from_bytes(
                    GLib.Bytes.new(data),
                    GdkPixbuf.Colorspace.RGB,
                    True,
                    8,
                    w,
                    h,
                    w * 4
                )
                self.frames.append(pixbuf)
        except Exception:
            sys.exit(1)
        
        if not self.frames:
            sys.exit(1)
            
        self.frame_index = 0
        self.scale = 0.7
        self.base_width = self.frames[0].get_width()
        self.base_height = self.frames[0].get_height()
        
        self.image = Gtk.Image()
        self.event_box = Gtk.EventBox()
        self.event_box.set_visible_window(False)
        self.event_box.add(self.image)
        
        box = Gtk.Box()
        box.pack_start(self.event_box, True, True, 0)
        self.add(box)
        
        self.event_box.add_events(
            Gdk.EventMask.BUTTON_PRESS_MASK |
            Gdk.EventMask.POINTER_MOTION_MASK |
            Gdk.EventMask.BUTTON_RELEASE_MASK |
            Gdk.EventMask.SCROLL_MASK
        )
        self.event_box.connect("button-press-event", self.on_press)
        self.event_box.connect("motion-notify-event", self.on_motion)
        self.event_box.connect("button-release-event", self.on_release)
        self.event_box.connect("scroll-event", self.on_scroll)
        
        self.dragging = False
        self.drag_start_x = 0
        self.drag_start_y = 0
        # self.window_x = 0
        # self.window_y = 0
        
        # w = int(self.base_width * self.scale)
        # h = int(self.base_height * self.scale)
        # self.window_x = self.screen_width - w - 40
        # self.window_y = self.screen_height - h - 10

        self.window_x = 100  # Distance from left
        self.window_y = 100  # Distance from top
        
        self.update_position()
        self.update_frame()
        
        GLib.timeout_add(80, self.next_frame)
        self.show_all()
    
    def update_position(self):
        self.window_x = max(0, min(self.window_x, self.screen_width - 1))
        self.window_y = max(0, min(self.window_y, self.screen_height - 1))
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.LEFT, int(self.window_x))
        GtkLayerShell.set_margin(self, GtkLayerShell.Edge.TOP, int(self.window_y))
    
    def on_press(self, widget, event):
        if event.button == 1:
            self.dragging = True
            self.drag_start_x = event.x_root
            self.drag_start_y = event.y_root
            return True
        return False
    
    def on_motion(self, widget, event):
        if self.dragging:
            dx = event.x_root - self.drag_start_x
            dy = event.y_root - self.drag_start_y
            self.window_x += dx
            self.window_y += dy
            self.update_position()
            self.drag_start_x = event.x_root
            self.drag_start_y = event.y_root
            return True
        return False
    
    def on_release(self, widget, event):
        if event.button == 1:
            self.dragging = False
            return True
        return False
    
    def on_scroll(self, widget, event):
        if event.direction == Gdk.ScrollDirection.UP:
            self.scale *= 1.05
        elif event.direction == Gdk.ScrollDirection.DOWN:
            self.scale *= 0.95
        
        self.scale = max(0.2, min(self.scale, 3.0))
        self.update_frame()
        return True
    
    def next_frame(self):
        self.frame_index = (self.frame_index + 1) % len(self.frames)
        self.update_frame()
        return True
    
    def update_frame(self):
        pixbuf = self.frames[self.frame_index]
        w = int(self.base_width * self.scale)
        h = int(self.base_height * self.scale)
        scaled = pixbuf.scale_simple(w, h, GdkPixbuf.InterpType.BILINEAR)
        self.image.set_from_pixbuf(scaled)
        self.set_size_request(w, h)

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    default_gif = os.path.join(script_dir, "chika.gif")
    
    gif_path = sys.argv[1] if len(sys.argv) > 1 else default_gif
    
    if not os.path.exists(gif_path):
        print(f"Error: GIF not found: {gif_path}", file=sys.stderr)
        sys.exit(1)
    
    app = FloatingWidget(gif_path)
    
    def signal_handler(sig, frame):
        Gtk.main_quit()
    
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    
    try:
        Gtk.main()
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    main()
