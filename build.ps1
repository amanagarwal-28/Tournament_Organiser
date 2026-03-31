Set-Content -Path "c:\CR\index.html" -Encoding UTF8 -Value @'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1.0" />
  <title>CR Tournament Manager</title>
  <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;600;700&family=Exo+2:wght@700;900&display=swap" rel="stylesheet"/>
  <style>
    *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
    :root{
      --bg:#07081a;--bg2:#0c0e22;--surface:#12152e;--card:#181b38;--card2:#1e2240;
      --border:#262a52;--glow:rgba(124,58,237,.3);
      --gold:#fbbf24;--gold2:#f59e0b;--gold3:#fde68a;--gold-dim:rgba(251,191,36,.15);
      --purple:#7c3aed;--purple-l:#a78bfa;--purple-d:#5b21b6;
      --green:#10b981;--red:#ef4444;--blue:#3b82f6;--cyan:#06b6d4;
      --text:#e2e8f0;--muted:#8892b8;
      --r1:#FFD700;--r2:#C0C0C0;--r3:#CD7F32;
    }
    body{
      font-family:'Rajdhani','Segoe UI',sans-serif;
      background:var(--bg);color:var(--text);min-height:100vh;
      background-image:
        radial-gradient(ellipse 60% 40% at 15% 15%,rgba(124,58,237,.07) 0%,transparent 70%),
        radial-gradient(ellipse 50% 40% at 85% 85%,rgba(59,130,246,.05) 0%,transparent 70%);
    }

    /* ── HEADER ── */
    header{
      background:linear-gradient(135deg,#080820 0%,#140a35 35%,#260e5a 65%,#140a35 100%);
      border-bottom:2px solid var(--gold2);
      position:relative;overflow:hidden;
    }
    header::before{
      content:'';position:absolute;inset:0;
      background:
        repeating-linear-gradient(45deg,transparent,transparent 40px,rgba(255,215,0,.018) 40px,rgba(255,215,0,.018) 41px),
        repeating-linear-gradient(-45deg,transparent,transparent 40px,rgba(124,58,237,.015) 40px,rgba(124,58,237,.015) 41px);
    }
    header::after{
      content:'';position:absolute;bottom:0;left:0;right:0;height:1px;
      background:linear-gradient(to right,transparent,var(--gold2),transparent);
    }
    .hdr-inner{
      max-width:1200px;margin:0 auto;padding:20px 28px;
      display:flex;align-items:center;gap:18px;position:relative;z-index:1;
    }
    .hdr-crown{
      font-size:3.2rem;
      filter:drop-shadow(0 0 16px rgba(255,215,0,.7)) drop-shadow(0 0 32px rgba(255,165,0,.4));
      animation:crownPulse 3s ease-in-out infinite;
    }
    @keyframes crownPulse{0%,100%{filter:drop-shadow(0 0 16px rgba(255,215,0,.7)) drop-shadow(0 0 32px rgba(255,165,0,.4))}50%{filter:drop-shadow(0 0 24px rgba(255,215,0,1)) drop-shadow(0 0 48px rgba(255,165,0,.6))}}
    .hdr-title{
      font-family:'Exo 2','Rajdhani',sans-serif;
      font-size:2rem;font-weight:900;letter-spacing:3px;
      background:linear-gradient(135deg,#fde68a 0%,#fbbf24 40%,#f59e0b 70%,#fde68a 100%);
      background-size:200% auto;
      -webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent;
      animation:shimmer 4s linear infinite;
    }
    @keyframes shimmer{to{background-position:200% center}}
    .hdr-sub{color:var(--purple-l);font-size:.78rem;letter-spacing:2px;margin-top:3px;text-transform:uppercase;}
    .hdr-badge{
      margin-left:auto;
      background:linear-gradient(135deg,var(--purple-d),var(--purple));
      border:1px solid rgba(167,139,250,.4);border-radius:20px;
      padding:5px 16px;font-size:.72rem;font-weight:800;letter-spacing:1.5px;
      color:var(--purple-l);text-transform:uppercase;
      box-shadow:0 0 12px rgba(124,58,237,.3);
    }

    /* ── NAV ── */
    nav{
      background:var(--bg2);border-bottom:1px solid var(--border);
      position:sticky;top:0;z-index:100;
      box-shadow:0 4px 20px rgba(0,0,0,.5);
    }
    .nav-inner{
      max-width:1200px;margin:0 auto;padding:0 28px;
      display:flex;gap:0;overflow-x:auto;
    }
    .nav-inner::-webkit-scrollbar{height:2px}
    .nav-inner::-webkit-scrollbar-thumb{background:var(--border)}
    .tab-btn{
      display:flex;align-items:center;gap:8px;
      padding:15px 22px;background:none;border:none;
      color:var(--muted);font-family:inherit;font-size:.88rem;font-weight:700;
      letter-spacing:.5px;cursor:pointer;white-space:nowrap;
      border-bottom:3px solid transparent;
      transition:color .2s,border-color .2s,background .2s;
      position:relative;
    }
    .tab-btn::after{
      content:'';position:absolute;bottom:0;left:50%;right:50%;height:3px;
      background:var(--gold);transition:left .25s,right .25s;border-radius:2px 2px 0 0;
    }
    .tab-btn.active::after{left:0;right:0;}
    .tab-btn:hover{color:var(--text);background:rgba(255,255,255,.03);}
    .tab-btn.active{color:var(--gold);}
    .tab-icon{font-size:1rem;}
    .tab-dot{width:7px;height:7px;border-radius:50%;background:var(--green);display:none;box-shadow:0 0 6px var(--green);}
    .tab-btn.has-data .tab-dot{display:block;}

    /* ── MAIN ── */
    main{max-width:1200px;margin:0 auto;padding:30px 28px;}
    .tab-panel{display:none;}
    .tab-panel.active{display:block;animation:fadeIn .25s ease;}
    @keyframes fadeIn{from{opacity:0;transform:translateY(6px)}to{opacity:1;transform:translateY(0)}}

    /* ── CARDS ── */
    .card{
      background:var(--card);border:1px solid var(--border);border-radius:16px;
      padding:24px 26px;margin-bottom:22px;position:relative;overflow:hidden;
    }
    .card::before{
      content:'';position:absolute;top:0;left:30px;right:30px;height:1px;
      background:linear-gradient(to right,transparent,rgba(167,139,250,.25),transparent);
    }
    .card-glow{box-shadow:0 0 30px rgba(124,58,237,.1);}
    .card-gold{border-color:rgba(251,191,36,.3);box-shadow:0 0 24px rgba(251,191,36,.08);}
    .card-hdr{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;}
    .card-title{
      font-size:1rem;font-weight:800;letter-spacing:.5px;color:var(--gold);
      display:flex;align-items:center;gap:9px;
    }
    .card-title-icon{font-size:1.15rem;}

    /* ── BUTTONS ── */
    .btn{
      display:inline-flex;align-items:center;gap:7px;
      padding:10px 22px;border:none;border-radius:10px;
      font-family:inherit;font-size:.88rem;font-weight:700;letter-spacing:.3px;
      cursor:pointer;transition:all .18s;
    }
    .btn:disabled{opacity:.38;cursor:not-allowed;}
    .btn-gold{
      background:linear-gradient(135deg,#d97706,#fbbf24 50%,#fde68a);
      background-size:200% auto;color:#1a0e00;
      box-shadow:0 4px 16px rgba(251,191,36,.3);
    }
    .btn-gold:hover:not(:disabled){background-position:right center;box-shadow:0 6px 22px rgba(251,191,36,.45);}
    .btn-purple{
      background:linear-gradient(135deg,var(--purple-d),var(--purple));color:#fff;
      box-shadow:0 4px 14px rgba(124,58,237,.3);
    }
    .btn-purple:hover:not(:disabled){background:linear-gradient(135deg,var(--purple),#9333ea);}
    .btn-green{
      background:linear-gradient(135deg,#059669,var(--green));color:#fff;
      box-shadow:0 4px 14px rgba(16,185,129,.25);
    }
    .btn-green:hover:not(:disabled){filter:brightness(1.1);}
    .btn-red{background:linear-gradient(135deg,#dc2626,var(--red));color:#fff;}
    .btn-red:hover:not(:disabled){filter:brightness(1.1);}
    .btn-ghost{background:transparent;border:1px solid var(--border);color:var(--muted);}
    .btn-ghost:hover:not(:disabled){border-color:var(--purple-l);color:var(--text);}
    .btn-sm{padding:5px 13px;font-size:.78rem;border-radius:8px;}

    /* ── INPUTS ── */
    input[type=text],input[type=number],select{
      background:var(--surface);border:1px solid var(--border);border-radius:10px;
      color:var(--text);padding:10px 14px;
      font-family:inherit;font-size:.9rem;outline:none;
      transition:border-color .2s,box-shadow .2s;
    }
    input:focus,select:focus{border-color:var(--purple-l);box-shadow:0 0 0 3px var(--glow);}
    input::placeholder{color:var(--muted);}
    select option{background:var(--surface);}

    /* ── REGISTRATION ── */
    .reg-row{display:flex;gap:10px;flex-wrap:wrap;margin-bottom:20px;}
    .reg-row input{flex:1;min-width:220px;}
    .player-tags{display:flex;flex-wrap:wrap;gap:9px;}
    .player-tag{
      display:flex;align-items:center;gap:7px;
      background:var(--surface);border:1px solid var(--border);border-radius:24px;
      padding:7px 16px;font-size:.85rem;font-weight:600;
      transition:border-color .2s;
    }
    .player-tag:hover{border-color:var(--purple-l);}
    .tag-num{
      width:22px;height:22px;border-radius:50%;
      background:var(--purple);color:#fff;
      display:flex;align-items:center;justify-content:center;
      font-size:.68rem;font-weight:800;flex-shrink:0;
    }
    .tag-del{background:none;border:none;color:var(--red);cursor:pointer;font-size:.9rem;line-height:1;padding:0 2px;opacity:.65;transition:opacity .15s;}
    .tag-del:hover{opacity:1;}
    .count-bar{
      margin-top:16px;padding:11px 16px;background:var(--surface);border-radius:10px;
      font-size:.82rem;color:var(--muted);display:flex;align-items:center;justify-content:space-between;
    }
    .count-bar em{color:var(--gold);font-style:normal;font-weight:700;}

    /* ── SETTINGS ── */
    .settings-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(190px,1fr));gap:16px;}
    .setting-item label{display:block;font-size:.7rem;font-weight:800;color:var(--muted);text-transform:uppercase;letter-spacing:1px;margin-bottom:7px;}
    .setting-item select,.setting-item input{width:100%;}

    /* ── GROUP PREVIEW ── */
    .group-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(155px,1fr));gap:14px;}
    .group-card{
      background:var(--surface);border:1px solid var(--border);border-radius:12px;
      padding:16px;transition:border-color .25s,box-shadow .25s;
    }
    .group-card:hover{border-color:var(--purple-l);box-shadow:0 0 16px rgba(167,139,250,.15);}
    .group-card-hdr{font-size:.75rem;font-weight:900;letter-spacing:1.5px;color:var(--gold);text-transform:uppercase;margin-bottom:12px;display:flex;align-items:center;justify-content:space-between;}
    .group-card-hdr span{color:var(--muted);font-size:.65rem;}
    .group-card ul{list-style:none;}
    .group-card ul li{padding:5px 0;font-size:.83rem;border-bottom:1px solid rgba(255,255,255,.05);display:flex;align-items:center;gap:7px;}
    .group-card ul li::before{content:'⚔';font-size:.6rem;opacity:.4;}
    .group-card ul li:last-child{border:none;}

    /* ── GROUP SELECTOR ── */
    .gs-selector{
      display:flex;align-items:center;gap:14px;margin-bottom:24px;flex-wrap:wrap;
      background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:14px 18px;
    }
    .gs-selector label{font-size:.7rem;font-weight:800;color:var(--muted);text-transform:uppercase;letter-spacing:1px;white-space:nowrap;}
    .gs-selector select{min-width:200px;}
    .gs-progress{margin-left:auto;display:flex;align-items:center;gap:10px;font-size:.8rem;color:var(--muted);}
    .prog-bar{width:120px;height:6px;background:var(--bg);border-radius:10px;overflow:hidden;border:1px solid var(--border);}
    .prog-fill{height:100%;background:linear-gradient(to right,var(--purple),var(--purple-l));border-radius:10px;transition:width .4s ease;}

    /* ── TABLES ── */
    .tbl-wrap{overflow-x:auto;border-radius:12px;border:1px solid var(--border);}
    table{width:100%;border-collapse:collapse;}
    thead tr{background:rgba(255,255,255,.025);}
    th{padding:11px 16px;text-align:left;font-size:.68rem;font-weight:800;letter-spacing:1px;color:var(--muted);text-transform:uppercase;border-bottom:1px solid var(--border);}
    td{padding:12px 16px;font-size:.88rem;vertical-align:middle;border-bottom:1px solid rgba(255,255,255,.035);}
    tr:last-child td{border-bottom:none;}
    tbody tr:hover td{background:rgba(124,58,237,.05);}

    /* ── SCORE INPUTS ── */
    .score-row{display:flex;align-items:center;gap:7px;}
    .score-row input{width:52px;text-align:center;padding:7px 4px;font-weight:700;}
    .score-sep{color:var(--muted);font-weight:900;font-size:1.1rem;}

    /* ── BADGES ── */
    .badge{display:inline-flex;align-items:center;padding:3px 10px;border-radius:20px;font-size:.65rem;font-weight:800;letter-spacing:.8px;text-transform:uppercase;}
    .badge-bo1{background:rgba(59,130,246,.15);color:#93c5fd;border:1px solid rgba(59,130,246,.25);}
    .badge-bo3{background:rgba(124,58,237,.15);color:#c4b5fd;border:1px solid rgba(124,58,237,.25);}
    .badge-bo5{background:rgba(245,158,11,.15);color:#fcd34d;border:1px solid rgba(245,158,11,.25);}
    .badge-done{background:rgba(16,185,129,.15);color:#6ee7b7;border:1px solid rgba(16,185,129,.25);}
    .badge-pending{background:rgba(255,255,255,.05);color:var(--muted);border:1px solid var(--border);}

    /* ── STANDINGS ── */
    .standings-wrap{margin-top:22px;}
    .standings-lbl{font-size:.7rem;font-weight:800;letter-spacing:1.5px;text-transform:uppercase;color:var(--purple-l);margin-bottom:10px;display:flex;align-items:center;gap:8px;}
    .standings-lbl::after{content:'';flex:1;height:1px;background:linear-gradient(to right,var(--border),transparent);}
    .adv-row td{background:rgba(16,185,129,.04) !important;}
    .adv-tag{display:inline-flex;align-items:center;font-size:.6rem;font-weight:900;color:var(--green);background:rgba(16,185,129,.15);border:1px solid rgba(16,185,129,.3);border-radius:10px;padding:1px 8px;margin-left:7px;}
    .rank-1 td:first-child{color:var(--r1);font-size:1rem;}
    .rank-2 td:first-child{color:var(--r2);}
    .rank-3 td:first-child{color:var(--r3);}

    /* ── BRACKET ── */
    .bracket-scroll{overflow-x:auto;padding-bottom:16px;}
    .bracket{display:flex;gap:36px;align-items:flex-start;min-width:max-content;padding:20px 4px;}
    .br-round{display:flex;flex-direction:column;}
    .br-round-lbl{font-size:.68rem;font-weight:900;letter-spacing:2px;text-transform:uppercase;color:var(--muted);text-align:center;margin-bottom:14px;}
    .br-round-lbl.gold-lbl{color:var(--gold);font-size:.78rem;}
    .br-matches{display:flex;flex-direction:column;}
    .br-spacer{flex:1;}
    .br-match{
      background:var(--card2);border:1px solid var(--border);border-radius:12px;
      width:236px;margin:8px 0;overflow:hidden;
      transition:border-color .2s,box-shadow .2s;
    }
    .br-match:hover{border-color:rgba(167,139,250,.4);}
    .br-match.live{border-color:var(--gold2);box-shadow:0 0 16px rgba(245,158,11,.2);}
    .br-match.grand-final{
      border-color:var(--gold2);border-width:2px;
      box-shadow:0 0 30px rgba(245,158,11,.25);
      background:linear-gradient(135deg,#1a1325,#1f1a45);
    }
    .br-mhdr{background:rgba(0,0,0,.25);padding:6px 12px;font-size:.65rem;color:var(--muted);display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid var(--border);}
    .br-player{display:flex;align-items:center;gap:8px;padding:10px 12px;font-size:.86rem;border-bottom:1px solid rgba(255,255,255,.04);}
    .br-player:last-of-type{border-bottom:none;}
    .br-player.winner{background:rgba(16,185,129,.1);font-weight:700;color:var(--green);}
    .br-player.loser{opacity:.42;}
    .br-player .pn{flex:1;min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
    .br-player .ps{font-weight:900;min-width:22px;text-align:right;}
    .br-player input{width:42px;text-align:center;padding:4px 2px;font-size:.8rem;}
    .br-tbd{color:var(--muted);font-style:italic;font-size:.8rem;}
    .br-actions{padding:8px 12px;display:flex;gap:7px;background:rgba(0,0,0,.15);border-top:1px solid var(--border);}

    /* ── CHAMPION ── */
    .champion-wrap{
      text-align:center;padding:44px 24px;margin-bottom:22px;
      background:linear-gradient(135deg,#0f0b22,#1e133d);
      border:2px solid var(--gold2);border-radius:20px;
      box-shadow:0 0 60px rgba(245,158,11,.15),inset 0 0 60px rgba(124,58,237,.05);
      position:relative;overflow:hidden;
    }
    .champion-wrap::before{
      content:'';position:absolute;inset:0;
      background:radial-gradient(ellipse at center,rgba(251,191,36,.06) 0%,transparent 65%);
    }
    .champ-crown{font-size:4.5rem;display:block;margin-bottom:10px;filter:drop-shadow(0 0 24px rgba(255,215,0,.9));animation:crownPulse 2s ease-in-out infinite;}
    .champ-lbl{font-size:.72rem;font-weight:900;letter-spacing:4px;color:var(--gold2);text-transform:uppercase;margin-bottom:6px;}
    .champ-name{
      font-family:'Exo 2','Rajdhani',sans-serif;font-size:2.6rem;font-weight:900;
      background:linear-gradient(135deg,#fde68a,#fbbf24,#f59e0b);
      background-size:200% auto;-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent;
      animation:shimmer 3s linear infinite;
    }

    /* ── LEADERBOARD ── */
    .lb-pts{font-weight:900;color:var(--gold);}
    .lb-name{font-weight:700;}

    /* ── ALERTS ── */
    .alert{padding:13px 18px;border-radius:11px;font-size:.88rem;margin-bottom:16px;display:flex;align-items:center;gap:10px;}
    .alert-icon{font-size:1.1rem;flex-shrink:0;}
    .alert-info{background:rgba(59,130,246,.08);border:1px solid rgba(59,130,246,.25);color:#93c5fd;}
    .alert-warn{background:rgba(245,158,11,.08);border:1px solid rgba(245,158,11,.25);color:#fcd34d;}
    .alert-success{background:rgba(16,185,129,.08);border:1px solid rgba(16,185,129,.25);color:#6ee7b7;}

    /* ── DIVIDER ── */
    .sec-lbl{font-size:.7rem;font-weight:900;letter-spacing:1.5px;text-transform:uppercase;color:var(--purple-l);margin-bottom:14px;padding-bottom:9px;border-bottom:1px solid var(--border);display:flex;align-items:center;gap:8px;}

    /* ── RESPONSIVE ── */
    @media(max-width:640px){
      main{padding:18px 16px;}
      .hdr-inner{padding:16px;}
      .hdr-title{font-size:1.35rem;}
      .tab-btn{padding:12px 14px;font-size:.8rem;}
      .nav-inner{padding:0 16px;}
      .card{padding:18px 16px;}
    }
  </style>
</head>
<body>

<header>
  <div class="hdr-inner">
    <div class="hdr-crown">&#x1F451;</div>
    <div>
      <div class="hdr-title">CR TOURNAMENT MANAGER</div>
      <div class="hdr-sub">Clash Royale Event Organizer</div>
    </div>
    <div class="hdr-badge" id="hdr-badge">Setup</div>
  </div>
</header>

<nav>
  <div class="nav-inner">
    <button class="tab-btn active" onclick="showTab('players',this)" data-tab="players">
      <span class="tab-icon">&#x2694;&#xFE0F;</span> Players <span class="tab-dot"></span>
    </button>
    <button class="tab-btn" onclick="showTab('group',this)" data-tab="group">
      <span class="tab-icon">&#x1F6E1;&#xFE0F;</span> Group Stage <span class="tab-dot"></span>
    </button>
    <button class="tab-btn" onclick="showTab('prefinals',this)" data-tab="prefinals">
      <span class="tab-icon">&#x1F3F9;</span> Pre-Finals <span class="tab-dot"></span>
    </button>
    <button class="tab-btn" onclick="showTab('finals',this)" data-tab="finals">
      <span class="tab-icon">&#x1F525;</span> Finals <span class="tab-dot"></span>
    </button>
    <button class="tab-btn" onclick="showTab('leaderboard',this)" data-tab="leaderboard">
      <span class="tab-icon">&#x1F4CA;</span> Leaderboard <span class="tab-dot"></span>
    </button>
  </div>
</nav>

<main>

  <!-- ═══ TAB: PLAYERS ═══ -->
  <div id="tab-players" class="tab-panel active">

    <div class="card card-glow">
      <div class="card-hdr">
        <div class="card-title"><span class="card-title-icon">&#x2694;&#xFE0F;</span> Player Registration</div>
      </div>
      <div class="reg-row">
        <input type="text" id="player-input" placeholder="Enter player name and press Enter…" onkeydown="if(event.key==='Enter')addPlayer()"/>
        <button class="btn btn-purple" onclick="addPlayer()">+ Add Player</button>
        <button class="btn btn-red btn-sm" onclick="clearAll()" style="margin-left:auto">&#x1F5D1; Reset</button>
      </div>
      <div class="player-tags" id="player-list"></div>
      <div class="count-bar" id="count-bar">
        <span><em>0</em> players registered</span>
        <span id="count-hint">Add at least 2 players to continue</span>
      </div>
    </div>

    <div class="card">
      <div class="card-hdr">
        <div class="card-title"><span class="card-title-icon">&#x2699;&#xFE0F;</span> Tournament Settings</div>
      </div>
      <div class="settings-grid">
        <div class="setting-item">
          <label>Max Players per Group</label>
          <select id="max-group-size">
            <option value="3">3 players</option>
            <option value="4">4 players</option>
            <option value="5" selected>5 players</option>
          </select>
        </div>
        <div class="setting-item">
          <label>Group Stage Format</label>
          <select id="group-format">
            <option value="bo1">BO1 &#x2014; Best of 1</option>
            <option value="bo3" selected>BO3 &#x2014; Best of 3</option>
            <option value="bo5">BO5 &#x2014; Best of 5</option>
          </select>
        </div>
        <div class="setting-item">
          <label>Semifinal Format</label>
          <select id="semi-format">
            <option value="bo1">BO1 &#x2014; Best of 1</option>
            <option value="bo3">BO3 &#x2014; Best of 3</option>
            <option value="bo5" selected>BO5 &#x2014; Best of 5</option>
          </select>
        </div>
        <div class="setting-item">
          <label>Grand Final Format</label>
          <select id="final-format">
            <option value="bo1">BO1 &#x2014; Best of 1</option>
            <option value="bo3">BO3 &#x2014; Best of 3</option>
            <option value="bo5" selected>BO5 &#x2014; Best of 5</option>
          </select>
        </div>
        <div class="setting-item">
          <label>Advance per Group</label>
          <select id="advance-count">
            <option value="1">1 &#x2014; Winner only</option>
            <option value="2" selected>2 &#x2014; Top 2</option>
            <option value="3">3 &#x2014; Top 3</option>
          </select>
        </div>
      </div>
    </div>

    <div class="card card-gold" id="group-preview-card" style="display:none">
      <div class="card-hdr">
        <div class="card-title"><span class="card-title-icon">&#x1F465;</span> Group Preview</div>
      </div>
      <div id="group-preview-content"></div>
      <div style="margin-top:20px;display:flex;gap:10px;flex-wrap:wrap">
        <button class="btn btn-ghost" onclick="shuffleGroups()">&#x1F500; Reshuffle</button>
        <button class="btn btn-gold" onclick="confirmAndGenerate()">&#x2705; Confirm &amp; Start Tournament</button>
      </div>
    </div>

    <button class="btn btn-gold" onclick="generateGroups()" style="font-size:1rem;padding:13px 32px">
      &#x1F3AF; Divide into Groups
    </button>

  </div>

  <!-- ═══ TAB: GROUP STAGE ═══ -->
  <div id="tab-group" class="tab-panel">
    <div id="group-stage-content">
      <div class="alert alert-info"><span class="alert-icon">&#x2139;&#xFE0F;</span> Head to the <strong>Players</strong> tab, register players, and click <strong>Divide into Groups</strong>.</div>
    </div>
  </div>

  <!-- ═══ TAB: PRE-FINALS ═══ -->
  <div id="tab-prefinals" class="tab-panel">
    <div id="prefinals-content">
      <div class="alert alert-info"><span class="alert-icon">&#x2139;&#xFE0F;</span> Complete all group stage matches to unlock the bracket.</div>
    </div>
  </div>

  <!-- ═══ TAB: FINALS ═══ -->
  <div id="tab-finals" class="tab-panel">
    <div id="finals-content">
      <div class="alert alert-info"><span class="alert-icon">&#x2139;&#xFE0F;</span> Generate the bracket first to see Finals.</div>
    </div>
  </div>

  <!-- ═══ TAB: LEADERBOARD ═══ -->
  <div id="tab-leaderboard" class="tab-panel">
    <div id="leaderboard-content">
      <div class="alert alert-info"><span class="alert-icon">&#x2139;&#xFE0F;</span> Leaderboard updates as match results are entered.</div>
    </div>
  </div>

</main>

<script>
// ═══════════════════════════════════════════════
//  STATE
// ═══════════════════════════════════════════════
let S = loadState();

function defaults() {
  return {
    players: [], groups: [],
    groupFormat: 'bo3', semiFormat: 'bo5', finalFormat: 'bo5',
    maxGroupSize: 5, advanceCount: 2,
    groupMatches: [], bracketMatches: [],
    bracketGenerated: false, selectedGroup: 0
  };
}

function loadState() {
  try {
    const r = localStorage.getItem('cr_t4');
    return r ? Object.assign(defaults(), JSON.parse(r)) : defaults();
  } catch(e) { return defaults(); }
}

function save() { localStorage.setItem('cr_t4', JSON.stringify(S)); }

// ═══════════════════════════════════════════════
//  HELPERS
// ═══════════════════════════════════════════════
const esc = s => String(s)
  .replace(/&/g,'&amp;').replace(/</g,'&lt;')
  .replace(/>/g,'&gt;').replace(/"/g,'&quot;');
const chr = i => String.fromCharCode(65 + i);
const boWins = f => f === 'bo5' ? 3 : f === 'bo3' ? 2 : 1;
const boMax  = f => f === 'bo5' ? 5 : f === 'bo3' ? 3 : 1;
function pow2(n) { let p = 1; while (p < n) p *= 2; return p; }

// ═══════════════════════════════════════════════
//  TABS
// ═══════════════════════════════════════════════
function showTab(id, btn) {
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
  document.getElementById('tab-' + id).classList.add('active');
  btn.classList.add('active');
  if (id === 'group')       renderGroupStage();
  if (id === 'prefinals')   renderPreFinals();
  if (id === 'finals')      renderFinals();
  if (id === 'leaderboard') renderLeaderboard();
}

function switchToTab(id) {
  const btn = document.querySelector('[data-tab="' + id + '"]');
  if (!btn) return;
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
  document.getElementById('tab-' + id).classList.add('active');
  btn.classList.add('active');
  if (id === 'group')       renderGroupStage();
  if (id === 'prefinals')   renderPreFinals();
  if (id === 'finals')      renderFinals();
  if (id === 'leaderboard') renderLeaderboard();
}

// ═══════════════════════════════════════════════
//  PLAYERS
// ═══════════════════════════════════════════════
function addPlayer() {
  const inp = document.getElementById('player-input');
  const name = inp.value.trim();
  if (!name) return;
  if (S.players.map(p => p.toLowerCase()).includes(name.toLowerCase())) {
    alert('Player already added!'); return;
  }
  S.players.push(name);
  inp.value = '';
  save();
  renderPlayers();
  inp.focus();
}

function removePlayer(i) {
  S.players.splice(i, 1);
  save();
  renderPlayers();
}

function clearAll() {
  if (!confirm('Reset everything and start fresh?')) return;
  S = defaults();
  save();
  renderPlayers();
  document.getElementById('group-preview-card').style.display = 'none';
  document.getElementById('group-stage-content').innerHTML  = mkInfo('Head to the <strong>Players</strong> tab first.');
  document.getElementById('prefinals-content').innerHTML    = mkInfo('Complete group stage first.');
  document.getElementById('finals-content').innerHTML       = mkInfo('Generate the bracket first.');
  document.getElementById('leaderboard-content').innerHTML  = mkInfo('Leaderboard updates as results are entered.');
  updateBadge();
}

function mkInfo(msg) {
  return '<div class="alert alert-info"><span class="alert-icon">&#x2139;&#xFE0F;</span>' + msg + '</div>';
}

function renderPlayers() {
  const list = document.getElementById('player-list');
  const bar  = document.getElementById('count-bar');
  const hint = document.getElementById('count-hint');
  list.innerHTML = S.players.map((p, i) =>
    '<div class="player-tag">' +
    '<span class="tag-num">' + (i+1) + '</span>' +
    '<span>' + esc(p) + '</span>' +
    '<button class="tag-del" onclick="removePlayer(' + i + ')" title="Remove">&#x2715;</button>' +
    '</div>'
  ).join('');
  const n = S.players.length;
  bar.innerHTML = '<span><em>' + n + '</em> player' + (n !== 1 ? 's' : '') + ' registered</span>' +
    '<span id="count-hint">' + (n >= 2 ? 'Ready to divide into groups' : 'Add at least 2 players to continue') + '</span>';
  document.querySelector('[data-tab="players"]').classList.toggle('has-data', n > 0);
}

// ═══════════════════════════════════════════════
//  GROUPS
// ═══════════════════════════════════════════════
function generateGroups() {
  if (S.players.length < 2) { alert('Add at least 2 players first.'); return; }
  S.maxGroupSize = parseInt(document.getElementById('max-group-size').value);
  doShuffle();
  save();
  showGroupPreview();
}

function shuffleGroups() { doShuffle(); save(); showGroupPreview(); }

function doShuffle() {
  const arr  = [...S.players].sort(() => Math.random() - .5);
  const size = S.maxGroupSize;
  const n    = Math.ceil(arr.length / size);
  S.groups   = Array.from({ length: n }, () => []);
  arr.forEach((p, i) => S.groups[i % n].push(p));
}

function showGroupPreview() {
  document.getElementById('group-preview-card').style.display = '';
  document.getElementById('group-preview-content').innerHTML =
    '<div class="group-grid">' +
    S.groups.map((g, gi) =>
      '<div class="group-card">' +
      '<div class="group-card-hdr">Group ' + chr(gi) + ' <span>' + g.length + 'p</span></div>' +
      '<ul>' + g.map(p => '<li>' + esc(p) + '</li>').join('') + '</ul>' +
      '</div>'
    ).join('') +
    '</div>';
}

function confirmAndGenerate() {
  S.groupFormat  = document.getElementById('group-format').value;
  S.semiFormat   = document.getElementById('semi-format').value;
  S.finalFormat  = document.getElementById('final-format').value;
  S.advanceCount = parseInt(document.getElementById('advance-count').value);

  S.groupMatches = [];
  S.groups.forEach((group, gi) => {
    const pairs = [];
    for (let a = 0; a < group.length; a++)
      for (let b = a + 1; b < group.length; b++)
        pairs.push({ group: gi, p1: group[a], p2: group[b] });
    // Fisher-Yates shuffle so matches within each group are in random order
    for (let i = pairs.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [pairs[i], pairs[j]] = [pairs[j], pairs[i]];
    }
    pairs.forEach(p => S.groupMatches.push({ ...p, id: S.groupMatches.length, s1: null, s2: null, winner: null, format: S.groupFormat }));
  });

  S.bracketGenerated = false;
  S.bracketMatches   = [];
  S.selectedGroup    = 0;
  save();
  document.querySelector('[data-tab="group"]').classList.add('has-data');
  switchToTab('group');
  updateBadge();
}

function updateBadge() {
  const el = document.getElementById('hdr-badge');
  if (!el) return;
  const allBracket = S.bracketMatches.length && S.bracketMatches.every(m => m.winner || m.isBye);
  if (allBracket)               el.textContent = 'Champion!';
  else if (S.bracketGenerated)  el.textContent = 'Bracket';
  else if (S.groupMatches.length) el.textContent = 'Group Stage';
  else                          el.textContent = 'Setup';
}

// ═══════════════════════════════════════════════
//  GROUP STAGE
// ═══════════════════════════════════════════════
function renderGroupStage() {
  const div = document.getElementById('group-stage-content');
  if (!S.groupMatches.length) {
    div.innerHTML = mkInfo('Head to the <strong>Players</strong> tab, add players, and click <strong>Divide into Groups</strong>.');
    return;
  }
  const sel   = Math.min(S.selectedGroup || 0, S.groups.length - 1);
  S.selectedGroup = sel;
  const total = S.groupMatches.length;
  const done  = S.groupMatches.filter(m => m.winner !== null).length;
  const pct   = total ? Math.round(done / total * 100) : 0;

  let html =
    '<div class="gs-selector">' +
    '<label>&#x1F4CB; View Group:</label>' +
    '<select onchange="selectGroup(this.value)" id="group-select">' +
    S.groups.map((g, gi) =>
      '<option value="' + gi + '"' + (gi === sel ? ' selected' : '') + '>Group ' + chr(gi) + ' &mdash; ' + g.length + ' players</option>'
    ).join('') +
    '</select>' +
    '<div class="gs-progress">' +
    '<span>' + done + '/' + total + ' matches</span>' +
    '<div class="prog-bar"><div class="prog-fill" style="width:' + pct + '%"></div></div>' +
    '<span>' + pct + '%</span>' +
    '</div></div>';

  html += renderOneGroup(sel);

  if (S.groupMatches.every(m => m.winner !== null)) {
    html += '<div class="alert alert-success" style="margin-top:16px">' +
      '<span class="alert-icon">&#x2705;</span> All group matches complete! ' +
      '<button class="btn btn-gold btn-sm" style="margin-left:auto" onclick="generateBracket()">&#x1F3C6; Generate Knockout Bracket</button>' +
      '</div>';
  }

  div.innerHTML = html;
}

function selectGroup(v) {
  S.selectedGroup = parseInt(v);
  save();
  renderGroupStage();
}

function renderOneGroup(gi) {
  const group   = S.groups[gi];
  const matches = S.groupMatches.filter(m => m.group === gi);
  const fmt     = matches[0] ? matches[0].format : 'bo3';
  const maxW    = boWins(fmt);
  const gdone   = matches.filter(m => m.winner).length;

  let h = '<div class="card card-glow">' +
    '<div class="card-hdr">' +
    '<div class="card-title">&#x2694;&#xFE0F; Group ' + chr(gi) + ' &mdash; Matches' +
    ' <span class="badge badge-' + fmt + '" style="margin-left:8px">' + fmt.toUpperCase() + '</span></div>' +
    '<span style="font-size:.78rem;color:var(--muted)">' + gdone + '/' + matches.length + ' done</span>' +
    '</div>' +
    '<div class="tbl-wrap"><table>' +
    '<thead><tr><th>#</th><th>Player 1</th><th>Score</th><th>Player 2</th><th>Status</th><th>Action</th></tr></thead>' +
    '<tbody>';

  matches.forEach((m, mi) => {
    const done = m.winner !== null;
    const w1 = done && m.winner === m.p1;
    const w2 = done && m.winner === m.p2;
    h += '<tr>' +
      '<td style="color:var(--muted);font-weight:700">' + (mi+1) + '</td>' +
      '<td style="font-weight:' + (w1?700:500) + ';color:' + (w1?'var(--green)':'inherit') + '">' + esc(m.p1) + '</td>' +
      '<td><div class="score-row">' +
      '<input type="number" min="0" max="' + boMax(fmt) + '" value="' + (m.s1 !== null ? m.s1 : '') + '" id="s1-' + m.id + '"' + (done?' disabled':'') + '/>' +
      '<span class="score-sep">&ndash;</span>' +
      '<input type="number" min="0" max="' + boMax(fmt) + '" value="' + (m.s2 !== null ? m.s2 : '') + '" id="s2-' + m.id + '"' + (done?' disabled':'') + '/>' +
      '</div></td>' +
      '<td style="font-weight:' + (w2?700:500) + ';color:' + (w2?'var(--green)':'inherit') + '">' + esc(m.p2) + '</td>' +
      '<td>' + (done ? '<span class="badge badge-done">Done</span>' : '<span class="badge badge-pending">Pending</span>') + '</td>' +
      '<td>' + (done
        ? '<button class="btn btn-ghost btn-sm" onclick="undoGroupMatch(' + m.id + ')">&#x21A9; Undo</button>'
        : '<button class="btn btn-green btn-sm" onclick="submitGroupMatch(' + m.id + ',' + maxW + ')">&#x2714; Submit</button>'
      ) + '</td></tr>';
  });

  h += '</tbody></table></div>' + renderStandingsTable(gi, group) + '</div>';
  return h;
}

function renderStandingsTable(gi, group) {
  const stats = {};
  group.forEach(p => { stats[p] = { w: 0, l: 0, pts: 0, gw: 0, gl: 0 }; });
  S.groupMatches.filter(m => m.group === gi && m.winner).forEach(m => {
    stats[m.winner].w++;
    stats[m.winner].pts += 3;
    const loser = m.winner === m.p1 ? m.p2 : m.p1;
    stats[loser].l++;
    stats[m.p1].gw += (m.s1 || 0); stats[m.p1].gl += (m.s2 || 0);
    stats[m.p2].gw += (m.s2 || 0); stats[m.p2].gl += (m.s1 || 0);
  });
  const sorted = Object.entries(stats).sort((a, b) =>
    b[1].pts - a[1].pts || (b[1].gw - b[1].gl) - (a[1].gw - a[1].gl)
  );
  let h = '<div class="standings-wrap"><div class="standings-lbl">&#x1F4CA; Standings</div>' +
    '<div class="tbl-wrap"><table>' +
    '<thead><tr><th>Rank</th><th>Player</th><th>W</th><th>L</th><th>Pts</th><th>GD</th></tr></thead><tbody>';
  sorted.forEach(([p, s], i) => {
    const adv = i < S.advanceCount;
    h += '<tr class="' + (adv ? 'adv-row ' : '') + 'rank-' + (i+1) + '">' +
      '<td style="font-weight:900">' + (i+1) + '</td>' +
      '<td class="lb-name">' + esc(p) + (adv ? '<span class="adv-tag">ADV</span>' : '') + '</td>' +
      '<td style="color:var(--green)">' + s.w + '</td>' +
      '<td style="color:var(--red)">' + s.l + '</td>' +
      '<td class="lb-pts">' + s.pts + '</td>' +
      '<td style="color:var(--muted)">' + (s.gw - s.gl >= 0 ? '+' : '') + (s.gw - s.gl) + '</td>' +
      '</tr>';
  });
  return h + '</tbody></table></div></div>';
}

function submitGroupMatch(id, maxW) {
  const m  = S.groupMatches.find(x => x.id === id);
  const s1 = parseInt(document.getElementById('s1-' + id).value);
  const s2 = parseInt(document.getElementById('s2-' + id).value);
  if (isNaN(s1) || isNaN(s2)) { alert('Enter scores for both players.'); return; }
  if (s1 < 0 || s2 < 0)       { alert('Scores cannot be negative.'); return; }
  if (s1 !== maxW && s2 !== maxW) { alert('One player must reach ' + maxW + ' win' + (maxW > 1 ? 's' : '') + '.'); return; }
  if (s1 === s2)               { alert('Scores cannot be equal.'); return; }
  m.s1 = s1; m.s2 = s2; m.winner = s1 > s2 ? m.p1 : m.p2;
  save();
  renderGroupStage();
  tryRefreshLB();
}

function undoGroupMatch(id) {
  const m = S.groupMatches.find(x => x.id === id);
  m.s1 = null; m.s2 = null; m.winner = null;
  save();
  renderGroupStage();
}

// ═══════════════════════════════════════════════
//  BRACKET
// ═══════════════════════════════════════════════
function getGroupRanking(gi) {
  const group = S.groups[gi];
  const stats = {};
  group.forEach(p => { stats[p] = { pts: 0, gw: 0, gl: 0 }; });
  S.groupMatches.filter(m => m.group === gi && m.winner).forEach(m => {
    stats[m.winner].pts += 3;
    stats[m.p1].gw += (m.s1 || 0); stats[m.p1].gl += (m.s2 || 0);
    stats[m.p2].gw += (m.s2 || 0); stats[m.p2].gl += (m.s1 || 0);
  });
  return Object.entries(stats)
    .sort((a, b) => b[1].pts - a[1].pts || (b[1].gw - b[1].gl) - (a[1].gw - a[1].gl))
    .map(([p]) => p);
}

function totalRoundsCalc() {
  const r0 = S.bracketMatches.filter(x => x.round === 0).length;
  return Math.log2(pow2(r0 * 2));
}

function generateBracket() {
  const seeds = [];
  for (let s = 0; s < S.advanceCount; s++)
    S.groups.forEach((_, gi) => { const r = getGroupRanking(gi); if (r[s]) seeds.push(r[s]); });

  const size   = pow2(seeds.length);
  const slots  = [...seeds, ...Array(size - seeds.length).fill(null)];
  const rounds = Math.log2(size);

  S.bracketMatches = [];
  let id = 0;

  for (let i = 0; i < size / 2; i++) {
    const p1 = slots[i * 2], p2 = slots[i * 2 + 1];
    const isBye = !p1 || !p2;
    S.bracketMatches.push({ id: id++, round: 0, matchNum: i, p1, p2, s1: null, s2: null, winner: isBye ? (p1 || p2) : null, isBye, format: 'tbd' });
  }
  for (let r = 1; r < rounds; r++) {
    const n = size / Math.pow(2, r + 1);
    for (let i = 0; i < n; i++)
      S.bracketMatches.push({ id: id++, round: r, matchNum: i, p1: null, p2: null, s1: null, s2: null, winner: null, isBye: false, format: 'tbd' });
  }

  S.bracketMatches.forEach(m => {
    const rev = rounds - 1 - m.round;
    m.format = rev === 0 ? S.finalFormat : rev === 1 ? S.semiFormat : 'bo3';
  });

  S.bracketMatches.filter(m => m.isBye && m.winner).forEach(m => advance(m));
  S.bracketGenerated = true;
  save();
  document.querySelector('[data-tab="prefinals"]').classList.add('has-data');
  document.querySelector('[data-tab="finals"]').classList.add('has-data');
  switchToTab('prefinals');
  updateBadge();
}

function advance(m) {
  const tr = totalRoundsCalc();
  if (m.round >= tr - 1) return;
  const next = S.bracketMatches.find(x => x.round === m.round + 1 && x.matchNum === Math.floor(m.matchNum / 2));
  if (!next) return;
  next[m.matchNum % 2 === 0 ? 'p1' : 'p2'] = m.winner;
}

function roundName(r, tr) {
  const rev = tr - 1 - r;
  if (rev === 0) return 'Grand Final';
  if (rev === 1) return 'Semifinals';
  if (rev === 2) return 'Quarterfinals';
  return 'Round of ' + Math.pow(2, rev + 1);
}

// ═══════════════════════════════════════════════
//  PRE-FINALS
// ═══════════════════════════════════════════════
function renderPreFinals() {
  const div = document.getElementById('prefinals-content');
  if (!S.bracketGenerated) {
    div.innerHTML = mkInfo('Complete all group stage matches then click <strong>Generate Knockout Bracket</strong>.');
    return;
  }
  const tr  = totalRoundsCalc();
  const pre = tr - 2;  // rounds 0 .. pre-1

  if (pre <= 0) {
    div.innerHTML = mkInfo('Not enough players for a pre-finals stage. Head to the <strong>Finals</strong> tab.');
    return;
  }

  let html = '<div class="card card-glow"><div class="card-hdr"><div class="card-title">&#x1F3F9; Pre-Finals Bracket</div></div>' +
    '<div class="bracket-scroll"><div class="bracket">';

  for (let r = 0; r < pre; r++) {
    const matches = S.bracketMatches.filter(m => m.round === r);
    if (!matches.length) continue;
    html += '<div class="br-round">' +
      '<div class="br-round-lbl">' + roundName(r, tr) + '</div>' +
      '<div class="br-matches">' +
      matches.map(m => renderBM(m, tr)).join('') +
      '</div></div>';
  }

  html += '</div></div></div>';
  div.innerHTML = html;
}

// ═══════════════════════════════════════════════
//  FINALS
// ═══════════════════════════════════════════════
function renderFinals() {
  const div = document.getElementById('finals-content');
  if (!S.bracketGenerated) {
    div.innerHTML = mkInfo('Generate the bracket first.');
    return;
  }

  const tr    = totalRoundsCalc();
  const start = Math.max(0, tr - 2);
  const finalM = S.bracketMatches.find(m => m.round === tr - 1 && m.matchNum === 0);
  const champ  = finalM ? finalM.winner : null;

  let html = '';

  if (champ) {
    html += '<div class="champion-wrap">' +
      '<span class="champ-crown">&#x1F451;</span>' +
      '<div class="champ-lbl">Tournament Champion</div>' +
      '<div class="champ-name">' + esc(champ) + '</div>' +
      '</div>';
  }

  html += '<div class="card card-gold"><div class="card-hdr"><div class="card-title">&#x1F525; Finals Bracket</div></div>' +
    '<div class="bracket-scroll"><div class="bracket">';

  for (let r = start; r < tr; r++) {
    const matches = S.bracketMatches.filter(m => m.round === r);
    if (!matches.length) continue;
    const isFinal = r === tr - 1;
    html += '<div class="br-round">' +
      '<div class="br-round-lbl' + (isFinal ? ' gold-lbl' : '') + '">' + (isFinal ? '&#x1F3C6; ' : '') + roundName(r, tr) + '</div>' +
      '<div class="br-matches">' +
      matches.map(m => renderBM(m, tr)).join('') +
      '</div></div>';
  }

  html += '</div></div></div>';
  div.innerHTML = html;
}

// ═══════════════════════════════════════════════
//  BRACKET MATCH HTML
// ═══════════════════════════════════════════════
function renderBM(m, tr) {
  const fmt   = m.format === 'tbd' ? 'bo3' : m.format;
  const done  = m.winner !== null;
  const w1    = done && m.winner === m.p1;
  const w2    = done && m.winner === m.p2;
  const ready = m.p1 && m.p2 && !done;
  const isFinalMatch = m.round === tr - 1;

  let h = '<div class="br-match' + (ready ? ' live' : '') + (isFinalMatch ? ' grand-final' : '') + '">' +
    '<div class="br-mhdr"><span>Match ' + (m.matchNum + 1) + '</span>' +
    '<span class="badge badge-' + fmt + '">' + fmt.toUpperCase() + '</span></div>';

  // Player 1
  h += '<div class="br-player' + (w1 ? ' winner' : done ? ' loser' : '') + '">' +
    '<span class="pn">' + (m.p1 ? esc(m.p1) : '<span class="br-tbd">TBD</span>') + '</span>';
  if (done) h += '<span class="ps" style="color:' + (w1 ? 'var(--green)' : 'inherit') + '">' + (m.s1 !== null ? m.s1 : '') + '</span>';
  else if (ready) h += '<input type="number" min="0" max="' + boMax(fmt) + '" id="bs1-' + m.id + '" />';
  h += '</div>';

  // Player 2
  h += '<div class="br-player' + (w2 ? ' winner' : done ? ' loser' : '') + '">' +
    '<span class="pn">' + (m.p2 ? esc(m.p2) : '<span class="br-tbd">TBD</span>') + '</span>';
  if (done) h += '<span class="ps" style="color:' + (w2 ? 'var(--green)' : 'inherit') + '">' + (m.s2 !== null ? m.s2 : '') + '</span>';
  else if (ready) h += '<input type="number" min="0" max="' + boMax(fmt) + '" id="bs2-' + m.id + '" />';
  h += '</div>';

  // Actions
  if (ready) {
    h += '<div class="br-actions"><button class="btn btn-green btn-sm" onclick="submitBM(' + m.id + ')">&#x2714; Submit</button></div>';
  } else if (done && !m.isBye) {
    h += '<div class="br-actions"><button class="btn btn-ghost btn-sm" onclick="undoBM(' + m.id + ')">&#x21A9; Undo</button></div>';
  }

  h += '</div>';
  return h;
}

// ═══════════════════════════════════════════════
//  BRACKET SUBMIT / UNDO
// ═══════════════════════════════════════════════
function submitBM(id) {
  const m    = S.bracketMatches.find(x => x.id === id);
  const fmt  = m.format === 'tbd' ? 'bo3' : m.format;
  const maxW = boWins(fmt);
  const s1   = parseInt(document.getElementById('bs1-' + id).value);
  const s2   = parseInt(document.getElementById('bs2-' + id).value);
  if (isNaN(s1) || isNaN(s2))           { alert('Enter scores.'); return; }
  if (s1 !== maxW && s2 !== maxW)        { alert('One player must reach ' + maxW + ' win' + (maxW > 1 ? 's' : '') + '.'); return; }
  if (s1 === s2)                         { alert('No draws allowed.'); return; }
  m.s1 = s1; m.s2 = s2; m.winner = s1 > s2 ? m.p1 : m.p2;
  advance(m);
  save();
  updateBadge();
  tryRefreshLB();
  const tr = totalRoundsCalc();
  if (m.round < tr - 2) renderPreFinals(); else renderFinals();
}

function undoBM(id) {
  const m  = S.bracketMatches.find(x => x.id === id);
  const next = S.bracketMatches.find(x => x.round === m.round + 1 && x.matchNum === Math.floor(m.matchNum / 2));
  if (next) {
    const slot = m.matchNum % 2 === 0 ? 'p1' : 'p2';
    if (next[slot] === m.winner) { next[slot] = null; next.winner = null; next.s1 = null; next.s2 = null; }
  }
  m.s1 = null; m.s2 = null; m.winner = null;
  save();
  updateBadge();
  tryRefreshLB();
  const tr = totalRoundsCalc();
  if (m.round < tr - 2) renderPreFinals(); else renderFinals();
}

// ═══════════════════════════════════════════════
//  LEADERBOARD
// ═══════════════════════════════════════════════
function tryRefreshLB() {
  if (document.getElementById('tab-leaderboard').classList.contains('active')) renderLeaderboard();
}

function renderLeaderboard() {
  const div = document.getElementById('leaderboard-content');
  if (!S.players.length) { div.innerHTML = mkInfo('No players yet.'); return; }

  const pts = {};
  S.players.forEach(p => { pts[p] = { gw: 0, gl: 0, bw: 0, bl: 0 }; });

  S.groupMatches.filter(m => m.winner).forEach(m => {
    if (pts[m.winner]) pts[m.winner].gw++;
    const l = m.winner === m.p1 ? m.p2 : m.p1;
    if (pts[l]) pts[l].gl++;
  });
  S.bracketMatches.filter(m => m.winner && !m.isBye).forEach(m => {
    if (pts[m.winner]) pts[m.winner].bw++;
    const l = m.winner === m.p1 ? m.p2 : m.p1;
    if (pts[l]) pts[l].bl++;
  });

  const medals  = ['&#x1F947;','&#x1F948;','&#x1F949;'];
  const sorted  = Object.entries(pts).sort((a, b) => {
    const pa = a[1].gw * 3 + a[1].bw * 5;
    const pb = b[1].gw * 3 + b[1].bw * 5;
    return pb - pa || b[1].gw - a[1].gw;
  });

  let html = '<div class="card card-glow">' +
    '<div class="card-title" style="margin-bottom:20px">&#x1F4CA; Overall Standings</div>' +
    '<div class="tbl-wrap"><table>' +
    '<thead><tr><th>#</th><th>Player</th><th>Group W</th><th>Group L</th><th>Bracket W</th><th>Total Pts</th></tr></thead>' +
    '<tbody>';

  sorted.forEach(([p, s], i) => {
    const total = s.gw * 3 + s.bw * 5;
    html += '<tr class="rank-' + (i+1) + '">' +
      '<td style="font-size:1.15rem">' + (medals[i] || (i+1)) + '</td>' +
      '<td class="lb-name">' + esc(p) + '</td>' +
      '<td style="color:var(--green)">' + s.gw + '</td>' +
      '<td style="color:var(--red)">' + s.gl + '</td>' +
      '<td style="color:var(--blue)">' + s.bw + '</td>' +
      '<td class="lb-pts">' + total + '</td>' +
      '</tr>';
  });

  html += '</tbody></table></div></div>';

  if (S.groups.length) {
    html += '<div class="card">' +
      '<div class="card-title" style="margin-bottom:20px">&#x1F6E1;&#xFE0F; Group Standings</div>';
    S.groups.forEach((g, gi) => {
      html += '<div class="sec-lbl">Group ' + chr(gi) + '</div>' + renderStandingsTable(gi, g);
    });
    html += '</div>';
  }

  div.innerHTML = html;
}

// ═══════════════════════════════════════════════
//  INIT
// ═══════════════════════════════════════════════
renderPlayers();
updateBadge();
if (S.groupMatches.length)   document.querySelector('[data-tab="group"]').classList.add('has-data');
if (S.bracketGenerated) {
  document.querySelector('[data-tab="prefinals"]').classList.add('has-data');
  document.querySelector('[data-tab="finals"]').classList.add('has-data');
}
</script>

</body>
</html>
'@
