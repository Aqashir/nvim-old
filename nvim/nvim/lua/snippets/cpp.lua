----------------------------------------------------------------------
--                         Local variables                          --

local utils = require('usr.utils')
local ls = utils.include('luasnip')
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = utils.include('luasnip.extras.fmt').fmt
local rep = utils.include('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup('Lua Snippets', { clear = true })
local file_pattern = '*.cpp'
----------------------------------------------------------------------


----------------------------------------------------------------------
--                           Snippets                             --


local randomNum = s({trig = 'random', name= 'Random', dscr = 'Generate a random number between min and max (inclusive)'},
    fmt(
[[
#include <random>

int getRandomNumber(int min, int max)
{{
    static std::mt19937 mt{{ std::random_device{{}}() }};

    std::uniform_int_distribution die{{ min, max }}; // we can create a distribution in any function that needs it

    return die(mt); // and then generate a random number from our global generator
}}
]],
    {

    })
)
table.insert(snippets, randomNum)



local timer= s({trig = 'timer', name= 'Timer', dscr = 'Misure the time of execution'},
    fmt(
[[
#include <chrono> // for std::chrono functions

class Timer
{{
private:
    // Type aliases to make accessing nested type easier
    using clock_type = std::chrono::steady_clock;
    using second_type = std::chrono::duration<double, std::ratio<1> >;

    std::chrono::time_point<clock_type> m_beg {{ clock_type::now() }};

public:
    void reset()
    {{
        m_beg = clock_type::now();
    }}

    double elapsed() const
    {{
        return std::chrono::duration_cast<second_type>(clock_type::now() - m_beg).count();
    }}
}};
]],
    {

    })
)
table.insert(snippets, timer)



local class = s('clas',
    fmt(
[[
class {} {}
{{
private: // Private variables
    {}

public: // Public variables


private: // Private methods


public: // Public methods

    // Constructor
    {}(void)
    {{

    }}

    // Destructor
    ~{}(void)
    {{

    }}

    // Copy constructor
    {}(const {}& copy)
    {{

    }}

    // Copy assignment operator
    {}& operator=(const {}& copy)
    {{

       return *this;
    }}

    // Move constructor
    {}({}&& move)
    {{

    }}

    // Move assignment operator
    {}& operator=({}&& move)
    {{

       return *this;
    }}

}};
]],
    {
        i(1, 'Name'),
        c(2, {t('final'), t('')}),
        i(3, ''),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
    }
    )
)
table.insert(snippets, class)



local main = s('main',
    fmt(
[[
int main({})
{{
    {}


    return 0;
}}
]],
    {
        c(1, {t('void'), t('int argc, char **argv')}),
        i(2, '')

    }
    )
)
table.insert(snippets, main)
----------------------------------------------------------------------


----------------------------------------------------------------------
--                        Return snippets                         --

return snippets, autosnippets
----------------------------------------------------------------------
