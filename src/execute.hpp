#include <iostream>
#include <cstdarg>
#include <string>
#include <fstream>
#include <memory>
#include <cstdio>

std::string exec(const char *cmd)
{
    std::shared_ptr<FILE> pipe(_popen(cmd, "r"), _pclose);
    if (!pipe)
        return "ERROR";
    char buffer[128];
    std::string result = "";
    while (!feof(pipe.get()))
    {
        if (fgets(buffer, 128, pipe.get()) != NULL)
            result += buffer;
    }
    return result;
}

/*
int main(int argc, char const *argv[]) {
    std::string str = exec("brew list");
    std::ofstream output;

    output.open("log.txt");

    if (output.is_open())
        output << str;

    output.close();
    return 0;
}
*/