jQuery ->
  if $('.endless_paginate').length
    $(window).scroll ->
      url = $('.endless_paginate .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 100
        $('.endless_paginate').text("努力加载中...")
        $.getScript(url)
    $(window).scroll()
