package core;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class UnixTreeCommand {
    int dirCount;
    int fileCount;

    List<String> tree = new ArrayList<>();

    public UnixTreeCommand() {
        dirCount = 0;
        fileCount = 0;
    }

    public List<String> getTree() {
        String directory = "/tmp";
        tree.add(directory);
        walk(new File(directory), "");
        tree.add("\n" + this.dirCount + " directories, " + this.fileCount + " files");
        return tree;
    }

    private void register(File file) {
        if (file.isDirectory()) {
            this.dirCount += 1;
        } else {
            this.fileCount += 1;
        }
    }

    private void walk(File folder, String prefix) {
        File file;
        File[] fileList = folder.listFiles();
        Arrays.sort(fileList);

        for (int index = 0; index < fileList.length; index++) {
            file = fileList[index];
            if (file.getName().charAt(0) == '.') {
                continue;
            }
            register(file);

            if (index == fileList.length - 1) {
                tree.add(prefix + "└── " + file.getName());
                if (file.isDirectory()) {
                    walk(file, prefix + "    ");
                }
            } else {
                tree.add(prefix + "├── " + file.getName());
                if (file.isDirectory()) {
                    walk(file, prefix + "│   ");
                }
            }
        }
    }
}