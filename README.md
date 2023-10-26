# plan.nvim

Simple todo list.

## Preview

![preview](/media/plan.gif)

## Installation

```
return {
  "kimpors/plan.nvim",

	keys = {
    { "--> YOUR KEYMAP HERE <--", "<cmd>lua require('plan').Dialog()<cr>"}
	},
}  
```

## Control

### Plans

`k` move up  
`j` move down  
`a` add plan  
`x` remove plan  
`l` move to Tasks  

### Tasks

`k` move up  
`j` move down  
`a` add task  
`x` remove task  
`l` toggle completeness  
`h` move to Plans  

## TODO

- [ ] Improve UI
    - [ ] Center menu
    - [ ] Add highlighting
    - [ ] Add complete percetange to plans
    - [ ] Think more -_-
- [ ] Add 'stage' (just one more layer)
- [ ] Come up with more ideas -_-
